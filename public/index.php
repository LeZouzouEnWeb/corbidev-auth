<?php
declare(strict_types=1);
define('API_GATEWAY', true);

ini_set('display_errors','1'); ini_set('display_startup_errors','1'); error_reporting(E_ALL);

$path = '/'.trim((string)($_GET['path'] ?? ''), '/');

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../src/App/bootstrap.php';
