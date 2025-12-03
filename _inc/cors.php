<?php
declare(strict_types=1);

/**
 * CORS simple basé sur .env
 */
$origins = getenv('CORS_ALLOW_ORIGINS') ?: '*';
$methods = getenv('CORS_ALLOW_METHODS') ?: 'GET,POST,OPTIONS';
$headers = getenv('CORS_ALLOW_HEADERS') ?: 'Content-Type,Authorization,X-Requested-With';

header("Access-Control-Allow-Origin: {$origins}");
header("Access-Control-Allow-Methods: {$methods}");
header("Access-Control-Allow-Headers: {$headers}");

if (strtoupper($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
    http_response_code(204);
    exit;
}
