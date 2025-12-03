<?php
declare(strict_types=1);

define('API_GATEWAY', true);
require __DIR__ . '/../vendor/autoload.php';

use App\Services\EnvDotenvBridge;
use App\Inc\Database;

header('Content-Type: text/plain; charset=utf-8');

EnvDotenvBridge::boot(dirname(__DIR__));

$logDir = dirname(__DIR__) . '/logs';
if (!is_dir($logDir)) {
    @mkdir($logDir, 0775, true);
}
$now = date('Y_m_d-H_i');
$logFile = $logDir . '/migration_' . $now . '.log';

$target = $_GET['file'] ?? ($argv[1] ?? '');
$target = (string)$target;

if ($target === '' || !is_file(dirname(__DIR__) . '/db/migrations/' . $target)) {
    http_response_code(400);
    echo "Usage: php public/migrate.php <fichier.sql>\n";
    exit;
}

$sqlPath = dirname(__DIR__) . '/db/migrations/' . $target;
$sql = file_get_contents($sqlPath);

try {
    $pdo = Database::pdo();
    $pdo->beginTransaction();
    $pdo->exec($sql);
    $pdo->commit();

    file_put_contents($logFile, "[OK] " . $target . " appliqué à " . date('c') . "\n", FILE_APPEND);
    @unlink($sqlPath);
    echo "Migration OK: " . $target . "\nLog: " . $logFile . "\n";
} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    file_put_contents($logFile, "[ERR] " . $target . " à " . date('c') . " — " . $e->getMessage() . "\n", FILE_APPEND);
    http_response_code(500);
    echo "Erreur migration (voir log).\n";
}
