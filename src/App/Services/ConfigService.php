<?php
declare(strict_types=1);

namespace App\Services;

/**
 * Charge la configuration application depuis config/app.json.
 *
 * @author ChatGPT
 */
final class ConfigService
{
    /** @var array<string,mixed> */
    private array $config;

    /**
     * @param string $configPath Chemin vers le fichier app.json
     */
    public function __construct(string $configPath)
    {
        $this->config = [
            'app_name' => 'Auth ENV',
            'title_h1' => 'Portail d\'accès DEV / HOMOL',
            'env' => 'DEV',
            'pages' => []
        ];
        if (is_readable($configPath)) {
            $json = file_get_contents($configPath);
            if ($json !== false) {
                $data = json_decode($json, true);
                if (is_array($data)) {
                    $this->config = array_merge($this->config, $data);
                }
            }
        }
    }

    /**
     * Retourne toute la configuration.
     * @return array<string,mixed>
     */
    public function all(): array
    {
        return $this->config;
    }

    /**
     * Retourne une clé de config.
     * @param string $key
     * @param mixed $default
     * @return mixed
     */
    public function get(string $key, mixed $default = null): mixed
    {
        return $this->config[$key] ?? $default;
    }
}
