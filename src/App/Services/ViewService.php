<?php
declare(strict_types=1);

namespace App\Services;

use App\Services\Twig\TwigFactory;
use App\Services\Twig\TwigRenderer;
use App\Services\CookieService;

/**
 * Service d'initialisation du moteur de vues (Twig).
 * - Configure Twig
 * - Injecte les variables globales (app, env)
 */
final class ViewService
{
    private TwigRenderer $renderer;

    public function __construct(string $templatesPath, string $cachePath, ConfigService $config)
    {
        $factory = new TwigFactory();
        $twig = $factory->create($templatesPath, $cachePath, false, [
            'app_name' => (string)$config->get('app_name', 'Auth ENV'),
            'ENV' => (string)$config->get('env', 'DEV'),
            'cookie_name' => CookieService::name(),
        ]);

        $this->renderer = new TwigRenderer($twig);
    }

    public function renderer(): TwigRenderer
    {
        return $this->renderer;
    }
}
