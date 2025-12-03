<?php
declare(strict_types=1);

namespace App\Services;

use App\Inc\Database;
use DateTimeImmutable;

final class AuthService
{
    /**
     * Retourne l'utilisateur courant depuis le cookie si valide, sinon null.
     * Applique les règles: compte actif, non expiré, mot de passe défini.
     * @return array<string,mixed>|null
     */
    public static function currentUser(): ?array
    {
        $cookieName = CookieService::name();
        $token = (string)($_COOKIE[$cookieName] ?? '');
        // Vérifie la signature si COOKIE_SALT est défini
        if ($token !== '' && CookieService::salt()) {
            $sig = (string)($_COOKIE[CookieService::sigName()] ?? '');
            if ($sig === '' || !hash_equals($sig, CookieService::hmac($token))) {
                return null; // cookie altéré
            }
        }
        if ($token === '') {
            return null;
        }
        $pdo = Database::pdo();
        $stmt = $pdo->prepare('SELECT id, email, role, status, is_active, valid_until, force_password_change, password_hash, login_token, updated_at FROM users WHERE login_token = :t LIMIT 1');
        $stmt->execute([':t' => $token]);
        $user = $stmt->fetch();
        if (!$user) {
            return null;
        }

        $now = new DateTimeImmutable('now');
        if (!in_array($user['status'] ?? 'disabled', ['active'], true)) {
            return null;
        }
        if (isset($user['is_active']) && (int)$user['is_active'] !== 1) {
            return null;
        }
        if (!empty($user['valid_until']) && (new DateTimeImmutable($user['valid_until'])) < $now) {
            return null;
        }
        if (empty($user['password_hash'])) {
            return null;
        }
        return $user;
    }

    /**
     * Vérifie si une rotation est nécessaire et la réalise côté serveur.
     * Retourne [user, token] (token éventuellement régénéré).
     * @return array{user: array<string,mixed>|null, token: string|null}
     */
    public static function checkAndRotate(): array
    {
        $user = self::currentUser();
        if (!$user) {
            return ['user' => null, 'token' => null];
        }
        $now = new DateTimeImmutable('now');
        $rotateAfter = CookieService::rotateInterval();
        $updatedAt = isset($user['updated_at']) && $user['updated_at'] !== null ? new DateTimeImmutable($user['updated_at']) : $now;
        $age = $now->getTimestamp() - $updatedAt->getTimestamp();
        if ($age < $rotateAfter) {
            // Rafraîchit simplement le cookie avec les paramètres actuels
            CookieService::setToken((string)$user['login_token']);
            return ['user' => $user, 'token' => (string)$user['login_token']];
        }
        // Rotation du token
        $newToken = bin2hex(random_bytes(32));
        $pdo = Database::pdo();
        $upd = $pdo->prepare('UPDATE users SET login_token = :t, updated_at = NOW() WHERE id = :id');
        $upd->execute([':t' => $newToken, ':id' => $user['id']]);
        CookieService::setToken($newToken);

        // Recharger un minimum les champs mis à jour
        $user['login_token'] = $newToken;
        $user['updated_at'] = (new DateTimeImmutable('now'))->format('Y-m-d H:i:s');
        return ['user' => $user, 'token' => $newToken];
    }
}
