<?php
declare(strict_types=1);

namespace App\Services\Twig;

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

/**
 * Fabrique d'Environment Twig.
 *
 * Rôle: centraliser la création et la configuration de Twig.
 * @param string $templatesPath Dossier des templates
 * @param string $cachePath Dossier du cache (si $useCache = true)
 * @param bool   $useCache Active le cache (PROD)
 * @param array<string,mixed> $globals Variables globales Twig
 * @return Environment Instance Twig configurée
 */
final class TwigFactory
{
    public static function create(
        string $templatesPath,
        string $cachePath,
        bool $useCache,
        array $globals = []
    ): Environment {
        $loader = new FilesystemLoader($templatesPath);

        $twig = new Environment($loader, [
            'cache' => $useCache ? $cachePath : false,
            'autoescape' => 'html',
            'strict_variables' => false
        ]);

        foreach ($globals as $k => $v) {
            $twig->addGlobal($k, $v);
        }

        return $twig;
    }
}
