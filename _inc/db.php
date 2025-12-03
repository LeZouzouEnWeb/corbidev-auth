<?php
declare(strict_types=1);

namespace App\Inc;

use PDO;
use PDOException;
use App\Services\EnvDotenvBridge;
use App\Services\MonologLoggerFactory;

/**
 * Database
 *
 * Rôle:
 *  - Fournir un accès PDO sécurisé via DSN en .env.
 *
 * Méthodes:
 *  - pdo(): PDO — connexion singleton.
 */
final class Database
{
    /** @var PDO|null */
    private static ?PDO $pdo = null;

    /**
     * Retourne une instance PDO.
     *
     * @return PDO
     */
    public static function pdo(): PDO
    {
        if (self::$pdo instanceof PDO) {
            return self::$pdo;
        }

        // Lire via EnvDotenvBridge (charge .env dans $_ENV/$_SERVER)
        $dsn = EnvDotenvBridge::get('DB_DSN', '');
        $user = EnvDotenvBridge::get('DB_USER', '');
        $pass = EnvDotenvBridge::get('DB_PASS', '');

        try {
            $pdo = new PDO($dsn, $user, $pass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
        } catch (PDOException $e) {
            $logger = MonologLoggerFactory::create('auth');
            $logger->error('DB connection failed', [
                'error' => $e->getMessage(),
                'dsn' => $dsn,
                'user' => $user,
            ]);

            http_response_code(500);
            $debug = (EnvDotenvBridge::get('APP_ENV') === 'dev') || in_array(strtolower((string)EnvDotenvBridge::get('APP_DEBUG', '0')), ['1','true'], true);
            $payload = [
                'ok' => false,
                'code' => 'DB_ERROR',
                'error' => 'Service indisponible',
                'detail' => [],
            ];
            if ($debug) {
                $payload['detail'] = ['message' => $e->getMessage()];
            }
            exit(json_encode($payload, JSON_UNESCAPED_SLASHES));
        }

        self::$pdo = $pdo;
        return self::$pdo;
    }
}
