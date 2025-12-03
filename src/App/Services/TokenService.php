<?php
declare(strict_types=1);

namespace App\Services;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use InvalidArgumentException;

/**
 * TokenService — JWT HS256
 */
final class TokenService
{
    private const DEFAULT_TTL = 3600;

    /**
     * @param array $claims
     * @param int|null $ttl
     * @return string
     */
    public static function issueToken(array $claims, ?int $ttl = null): string
    {
        $secret = EnvDotenvBridge::get('JWT_SECRET');
        if (!$secret) {
            throw new InvalidArgumentException('JWT secret manquant (JWT_SECRET).');
        }
        $now = time();
        $ttl = $ttl ?? (int)(EnvDotenvBridge::get('JWT_TTL', (string)self::DEFAULT_TTL));
        if ($ttl <= 0) {
            $ttl = self::DEFAULT_TTL;
        }

        $payload = array_merge([
            'iat' => $now,
            'exp' => $now + $ttl,
        ], self::stdClaims(), $claims);

        return JWT::encode($payload, $secret, 'HS256');
    }

    /**
     * @param string $jwt
     * @return array
     */
    public static function verifyToken(string $jwt): array
    {
        $secret = EnvDotenvBridge::get('JWT_SECRET');
        if (!$secret) {
            throw new InvalidArgumentException('JWT secret manquant (JWT_SECRET).');
        }
        $decoded = JWT::decode($jwt, new Key($secret, 'HS256'));
        return json_decode(json_encode($decoded), true, 512, JSON_THROW_ON_ERROR);
    }

    /**
     * @return array<string,string>
     */
    private static function stdClaims(): array
    {
        $c = [];
        $iss = EnvDotenvBridge::get('JWT_ISS');
        if ($iss) { $c['iss'] = $iss; }
        $aud = EnvDotenvBridge::get('JWT_AUD');
        if ($aud) { $c['aud'] = $aud; }
        return $c;
    }
}
