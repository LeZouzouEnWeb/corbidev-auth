<?php
declare(strict_types=1);

namespace App\Services;

/**
 * CookieService — centralise la config et les opérations cookies.
 */
final class CookieService
{
    public static function name(): string
    {
        return EnvDotenvBridge::get('COOKIE_NAME', 'auth_key') ?? 'auth_key';
    }

    public static function domain(): string
    {
        return EnvDotenvBridge::get('COOKIE_DOMAIN', '.corbisier.fr') ?? '.corbisier.fr';
    }

    public static function ttl(): int
    {
        $ttl = (int) (EnvDotenvBridge::get('COOKIE_TTL', (string)(60 * 60 * 24 * 7)) ?? 604800);
        return $ttl > 0 ? $ttl : 604800;
    }

    public static function secure(): bool
    {
        return (bool) filter_var(EnvDotenvBridge::get('COOKIE_SECURE', '1'), FILTER_VALIDATE_BOOL);
    }

    public static function httpOnly(): bool
    {
        return (bool) filter_var(EnvDotenvBridge::get('COOKIE_HTTPONLY', '1'), FILTER_VALIDATE_BOOL);
    }

    public static function sameSite(): string
    {
        return EnvDotenvBridge::get('COOKIE_SAMESITE', 'None') ?? 'None';
    }

    public static function rotateInterval(): int
    {
        // Intervalle de régénération du token (indépendant du TTL cookie)
        $sec = (int) (EnvDotenvBridge::get('COOKIE_ROTATE_SECONDS', '86400') ?? 86400);
        return $sec > 0 ? $sec : 86400;
    }

    public static function salt(): ?string
    {
        $s = EnvDotenvBridge::get('COOKIE_SALT');
        return $s !== null && $s !== '' ? $s : null;
    }

    public static function sigName(): string
    {
        return EnvDotenvBridge::get('COOKIE_SIG_NAME', self::name() . '_sig') ?? (self::name() . '_sig');
    }

    public static function hmac(string $token): string
    {
        $salt = self::salt();
        return base64_encode(hash_hmac('sha256', $token, $salt ?? '', true));
    }

    /**
     * Dépose le cookie d'authentification partagé avec les bonnes options.
     */
    public static function setToken(string $token): void
    {
        // Cookie principal avec le token brut (contrainte inter-sites)
        setcookie(self::name(), $token, [
            'expires'  => time() + self::ttl(),
            'path'     => '/',
            'domain'   => self::domain(),
            'secure'   => self::secure(),
            'httponly' => self::httpOnly(),
            'samesite' => self::sameSite(),
        ]);
        // Cookie de signature si un sel est défini (détection de falsification)
        if (self::salt()) {
            setcookie(self::sigName(), self::hmac($token), [
                'expires'  => time() + self::ttl(),
                'path'     => '/',
                'domain'   => self::domain(),
                'secure'   => self::secure(),
                'httponly' => self::httpOnly(),
                'samesite' => self::sameSite(),
            ]);
        }
    }

    /**
     * Supprime le cookie d'authentification partagé.
     */
    public static function clear(): void
    {
        setcookie(self::name(), '', [
            'expires'  => time() - 3600,
            'path'     => '/',
            'domain'   => self::domain(),
            'secure'   => self::secure(),
            'httponly' => self::httpOnly(),
            'samesite' => self::sameSite(),
        ]);
        if (self::salt()) {
            setcookie(self::sigName(), '', [
                'expires'  => time() - 3600,
                'path'     => '/',
                'domain'   => self::domain(),
                'secure'   => self::secure(),
                'httponly' => self::httpOnly(),
                'samesite' => self::sameSite(),
            ]);
        }
    }
}
