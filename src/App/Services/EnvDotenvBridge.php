<?php
declare(strict_types=1);

namespace App\Services;

use Dotenv\Dotenv;

/**
 * EnvDotenvBridge — centralise le chargement des variables d'environnement (.env*).
 *
 * Priorité souhaitée :
 *  1) `.env.dev` (chargé en premier, **mutable** ⇒ écrase les valeurs existantes)
 *  2) `.env`     (chargé ensuite, **immutable** + safeLoad ⇒ complète sans écraser)
 *
 * Emplacements testés, dans l'ordre : `config/` puis la racine du projet.
 * La classe est idempotente (boot() multi-appel sans effet).
 */
final class EnvDotenvBridge
{
    /** Empêche les chargements multiples */
    private static bool $booted = false;

    /** Liste des fichiers effectivement chargés (chemins absolus) */
    private static array $loadedFiles = [];

    /**
     * Initialise le chargement des fichiers .env*.
     *
     * @param string $rootDir Chemin racine du projet (ex: .../AUTH)
     * @return void
     */
    public static function boot(string $rootDir): void
    {
        if (self::$booted) {
            return; // Early return — déjà chargé
        }

        if (!class_exists(Dotenv::class)) {
            self::$booted = true; // Ne rien casser si phpdotenv absent
            return;
        }

        $configDir = rtrim($rootDir, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . 'config';
        $rootAsFallback = rtrim($rootDir, DIRECTORY_SEPARATOR);

        // Emplacements à tester, dans l'ordre
        $locations = [$configDir, $rootAsFallback];

        // 1) Charger .env.dev EN PREMIER (prioritaire) — mutable => écrase si déjà défini
        foreach ($locations as $loc) {
            $envDevFile = $loc . DIRECTORY_SEPARATOR . '.env.dev';
            if (is_file($envDevFile)) {
                $dotenvDev = Dotenv::createMutable($loc, '.env.dev'); // mutable = override
                $dotenvDev->load();
                self::markLoaded($envDevFile);
                break; // premier trouvé gagne
            }
        }

        // 2) Charger .env ENSUITE en safeLoad (complète sans écraser)
        foreach ($locations as $loc) {
            $envDefaultFile = $loc . DIRECTORY_SEPARATOR . '.env';
            if (is_file($envDefaultFile)) {
                $dotenv = Dotenv::createImmutable($loc, '.env'); // immutable = n'écrase pas
                $dotenv->safeLoad(); // complète uniquement
                self::markLoaded($envDefaultFile);
                break; // premier trouvé gagne
            }
        }

        self::$booted = true;
    }

    /**
     * Retourne une variable d'environnement.
     *
     * @param string $key
     * @param string|null $default
     * @return string|null
     */
    public static function get(string $key, ?string $default = null): ?string
    {
        $value = $_ENV[$key] ?? $_SERVER[$key] ?? getenv($key);
        if ($value === false || $value === null || $value === '') {
            return $default;
        }
        return (string)$value;
    }

    /**
     * Donne la liste des fichiers .env chargés (chemins absolus).
     *
     * @return array<int,string>
     */
    public static function filesLoaded(): array
    {
        return self::$loadedFiles;
    }

    /**
     * Ajoute un fichier à la liste interne + log en DEBUG (si APP_DEBUG actif).
     *
     * @param string $path
     * @return void
     */
    private static function markLoaded(string $path): void
    {
        self::$loadedFiles[] = $path;
        $debug = ($_ENV['APP_DEBUG'] ?? $_SERVER['APP_DEBUG'] ?? getenv('APP_DEBUG') ?? '0');
        $debugOn = in_array(strtolower((string)$debug), ['1', 'true', 'yes'], true);
        if ($debugOn) {
            error_log('[EnvDotenvBridge] loaded: ' . $path);
        }
    }
}
