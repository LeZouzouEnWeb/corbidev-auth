<?php
declare(strict_types=1);

use Bramus\Router\Router;
use App\Services\ConfigService;
use App\Services\ViewService;
use App\Services\EnvDotenvBridge;
use App\Services\CookieService;
use App\Services\AuthService;
use App\Inc\Database;

$router = new Router();

// Prepare services
$root = dirname(__DIR__, 2);
EnvDotenvBridge::boot($root);
require_once $root . '/_inc/db.php';
$config = new ConfigService($root . '/config/app.json');
$view = new ViewService($root . '/templates', $root . '/var/cache/twig', $config);
$renderer = $view->renderer();

// Middleware: auth + rotation (server-side only)
$router->before('GET|POST', '/.*', function () {
    $auth = AuthService::checkAndRotate();
    $GLOBALS['AUTH_USER'] = $auth['user'];
    $GLOBALS['AUTH_TOKEN'] = $auth['token'];
});

// Home
$router->get('/', function () use ($renderer, $config) {
    header('Content-Type: text/html; charset=utf-8');
    echo $renderer->render('views/home.html.twig', [
        'pages' => $config->get('pages', []),
        'current_path' => '/',
        'title_h1' => (string)$config->get('title_h1', "Portail d'accès DEV / HOMOL"),
        'user' => $GLOBALS['AUTH_USER'] ?? null,
        'auth_token' => $GLOBALS['AUTH_TOKEN'] ?? null,
    ]);
});

// Login (view)
$router->get('/login', function () use ($renderer, $config) {
    header('Content-Type: text/html; charset=utf-8');
    echo $renderer->render('views/login.html.twig', [
        'pages' => $config->get('pages', []),
        'current_path' => '/login',
        'title_h1' => (string)$config->get('title_h1', "Portail d'accès DEV / HOMOL"),
        'error' => null,
        'csrf_token' => '',
        'user' => $GLOBALS['AUTH_USER'] ?? null,
        'auth_token' => $GLOBALS['AUTH_TOKEN'] ?? null,
    ]);
});

// Login handler (POST)
$router->post('/login', function () use ($renderer, $config) {
    header('Content-Type: text/html; charset=utf-8');

    $emailOrLogin = trim((string)($_POST['login'] ?? ''));
    $password = (string)($_POST['password'] ?? '');

    if ($emailOrLogin === '' || $password === '') {
        http_response_code(400);
        echo $renderer->render('views/login.html.twig', [
            'pages' => $config->get('pages', []),
            'current_path' => '/login',
            'title_h1' => (string)$config->get('title_h1', "Portail d'accès DEV / HOMOL"),
            'error' => 'Identifiants manquants.',
            'csrf_token' => ''
        ]);
        return;
    }

    $pdo = Database::pdo();
    $stmt = $pdo->prepare('SELECT id, email, password_hash, role, status, is_active, valid_until, force_password_change, login_token FROM users WHERE email = :email LIMIT 1');
    $stmt->execute([':email' => $emailOrLogin]);
    $user = $stmt->fetch();

    $err = null;
    $now = new DateTimeImmutable('now');
    if (!$user) {
        $err = 'Utilisateur introuvable.';
    } elseif (!in_array($user['status'] ?? 'disabled', ['active'], true)) {
        $err = 'Compte inactif.';
    } elseif (isset($user['is_active']) && (int)$user['is_active'] !== 1) {
        $err = 'Compte désactivé.';
    } elseif (!empty($user['valid_until']) && (new DateTimeImmutable($user['valid_until'])) < $now) {
        $err = 'Compte expiré.';
    } elseif (empty($user['password_hash'])) {
        $err = 'Mot de passe non défini. Veuillez l’activer lors de la première connexion.';
    } elseif (!password_verify($password, (string)$user['password_hash'])) {
        $err = 'Identifiants invalides.';
    }

    if ($err) {
        http_response_code(401);
        echo $renderer->render('views/login.html.twig', [
            'pages' => $config->get('pages', []),
            'current_path' => '/login',
            'title_h1' => (string)$config->get('title_h1', "Portail d'accès DEV / HOMOL"),
            'error' => $err,
            'csrf_token' => ''
        ]);
        return;
    }

    // Ensure login_token exists
    $token = (string)($user['login_token'] ?? '');
    if ($token === '') {
        $token = bin2hex(random_bytes(32));
        $upd = $pdo->prepare('UPDATE users SET login_token = :t, updated_at = NOW() WHERE id = :id');
        $upd->execute([':t' => $token, ':id' => $user['id']]);
    }

    CookieService::setToken($token);

    echo $renderer->render('views/login_success.html.twig', [
        'token' => $token,
        'redirect_to' => '/',
        'cookie_name' => CookieService::name(),
        'user' => $GLOBALS['AUTH_USER'] ?? null,
        'auth_token' => $token,
    ]);
});

// Logout
$router->post('/logout', function () use ($renderer) {
    header('Content-Type: text/html; charset=utf-8');
    $cookieName = CookieService::name();
    CookieService::clear();
    echo $renderer->render('views/logout_success.html.twig', [
        'cookie_name' => $cookieName,
        'redirect_to' => '/',
        'user' => null,
        'auth_token' => null,
    ]);
});

$router->run();
