<?php
declare(strict_types=1);

/**
 * Définit la constante API_GATEWAY et renforce les paramètres de cookies.
 * À inclure automatiquement via composer.json (autoload.files).
 */

if (!defined('API_GATEWAY')) {
    define('API_GATEWAY', true);
}

ini_set('session.cookie_httponly', '1');
ini_set('session.cookie_secure', '1');
ini_set('session.cookie_samesite', 'Strict');

header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: DENY');
header('Referrer-Policy: no-referrer');
