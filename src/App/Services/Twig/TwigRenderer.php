<?php
declare(strict_types=1);

namespace App\Services\Twig;

use Twig\Environment;

/**
 * Service de rendu Twig.
 *
 * Rôle: encapsuler le rendu Twig.
 */
final class TwigRenderer
{
    private Environment $twig;

    public function __construct(Environment $twig)
    {
        $this->twig = $twig;
    }

    /**
     * Rend un template Twig.
     * @param string $template Nom du template (ex: 'demo/home.html.twig')
     * @param array<string,mixed> $data Données à injecter
     * @return string HTML rendu
     */
    public function render(string $template, array $data = []): string
    {
        return $this->twig->render($template, $data);
    }
}
