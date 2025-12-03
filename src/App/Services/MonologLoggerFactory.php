<?php
declare(strict_types=1);

namespace App\Services;

use Monolog\Logger;
use Monolog\Handler\RotatingFileHandler;
use Monolog\Handler\StreamHandler;
use Psr\Log\LoggerInterface;

/**
 * MonologLoggerFactory
 *
 * Correction: par défaut, écrire dans `auth/logs/` (dirname(__DIR__,3)) au lieu du dossier parent.
 */
final class MonologLoggerFactory
{
    /**
     * Crée un logger Monolog.
     *
     * @param string $channel
     * @param string|null $logDir
     * @return LoggerInterface
     */
    public static function create(string $channel, ?string $logDir = null): LoggerInterface
    {
        // __DIR__ = auth/src/App/Services -> remonter 3 niveaux = auth/
        $defaultLogDir = dirname(__DIR__, 3) . '/logs';
        $logDir = $logDir ?: (getenv('LOG_DIR') ?: $defaultLogDir);

        if (!is_dir($logDir)) {
            @mkdir($logDir, 0775, true);
        }

        $logger = new Logger($channel);

        // 1) Fichier par canal avec rotation
        $filename = rtrim($logDir, '/').'/'.$channel.'.log';
        $logger->pushHandler(new RotatingFileHandler($filename, 7, Logger::INFO, true, 0664));

        // 2) En dev: console partagée + stdout
        $appEnv   = (string)(getenv('APP_ENV') ?: '');
        $appDebug = strtolower((string)(getenv('APP_DEBUG') ?: '0'));
        $devMode  = $appEnv === 'dev' or $appDebug === '1' or $appDebug === 'true';

        if ($devMode) {
            $consoleName = (string)(getenv('CONSOLE_LOG_FILENAME') ?: 'debug-console.log');
            $consoleFile = rtrim($logDir, '/').'/'.$consoleName;
            $logger->pushHandler(new StreamHandler($consoleFile, Logger::DEBUG, true, 0664));
            $logger->pushHandler(new StreamHandler('php://stdout', Logger::DEBUG, true));
        }

        return $logger;
    }
}
