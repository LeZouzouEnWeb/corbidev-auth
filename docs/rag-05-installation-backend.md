# RAG-05 — Installation Backend (Symfony 7) pour corbidev-auth

## Installation initiale

```powershell
# Créer le squelette Symfony 7 dans le répertoire courant
composer create-project symfony/skeleton:"7.0.*" ./

# Installer le pack webapp (Twig, AssetMapper, formulaires, sécurité, etc.)
composer require webapp
```

## Structure des dossiers créés

- `assets/`: contient les assets front-end (JavaScript, CSS) gérés par AssetMapper ou Webpack Encore.
- `bin/`: exécutables pour interagir avec Symfony (console, phpunit).
- `config/`: configuration des modules Symfony au format YAML.
- `migrations/`: migrations Doctrine pour versionner l'évolution de la base de données.
- `public/`: racine du serveur web; éléments publics (images, CSS, JS compilés).
- `src/`: classes PHP sous le namespace `\App` (autoload via `composer.json`).
- `templates/`: fichiers Twig pour le rendu HTML des pages.
- `tests/`: tests unitaires et fonctionnels.
- `translations/`: fichiers de traduction pour le multi-langue.
- `var/`: logs et cache (doit être accessible en écriture).

## Fichiers d'environnement

- `.env`: versionné, contient les variables par défaut.
- `.env.local`: non commité, pour variables spécifiques à votre machine (secrets, DB locale, etc.).

## Démarrage serveur de développement

### Option 1: Serveur interne PHP

```powershell
php -S localhost:8000 -t public
```

Accessible sur: http://localhost:8000

### Option 2: Symfony CLI (recommandé)

```powershell
# Installer Symfony CLI: https://symfony.com/download
symfony serve
```

Accessible sur: https://127.0.0.1:8000 (HTTPS par défaut)

### Option 3: Serveur web externe

Configurer Nginx/Apache/Caddy pour pointer vers `public/` comme racine DocumentRoot.

## Packages supplémentaires recommandés

```powershell
# ORM Doctrine + migrations
composer require symfony/orm-pack doctrine/migrations

# AssetMapper (déjà inclus dans webapp) + Sass
composer require symfony/asset-mapper symfonycasts/sass-bundle

# Sécurité & authentification
composer require symfony/security-bundle symfony/password-hasher

# Vérification email
composer require symfonycasts/verify-email-bundle

# Rate limiting (anti-bruteforce)
composer require symfony/rate-limiter

# Mailer
composer require symfony/mailer

# Client OIDC (si besoin bundle générique)
composer require knpuniversity/oauth2-client-bundle

# JWT (si APIs internes)
composer require lexik/jwt-authentication-bundle
```

## Commandes utiles

```powershell
# Lister les routes
php bin/console debug:router

# Créer un contrôleur
php bin/console make:controller

# Créer une entité Doctrine
php bin/console make:entity

# Générer une migration
php bin/console make:migration

# Appliquer les migrations
php bin/console doctrine:migrations:migrate

# Vider le cache
php bin/console cache:clear
```

## Configuration OIDC/Keycloak

- Variables à définir dans `.env.local` (voir section Configuration du RAG principal).
- Créer un contrôleur `OidcController` avec routes `/oidc/login` (redirige vers Keycloak) et `/oidc/callback` (gère le retour).

## Checklist post-installation

- [ ] `.env.local` créé avec secrets et DB locale.
- [ ] Docker Compose lancé (`docker compose up -d`) pour MariaDB + Adminer.
- [ ] Base de données créée via Adminer ou CLI: `php bin/console doctrine:database:create`.
- [ ] Serveur de dev lancé: `php -S localhost:8000 -t public` ou `symfony serve`.
- [ ] Page d'accueil Symfony accessible.
- [ ] Entité `User` créée (si besoin auth local): `php bin/console make:user`.

## Références

- Symfony Installation: [symfony.com/doc/current/setup.html](https://symfony.com/doc/current/setup.html)
- Symfony CLI: [symfony.com/download](https://symfony.com/download)
- Doctrine: [symfony.com/doc/current/doctrine.html](https://symfony.com/doc/current/doctrine.html)
- AssetMapper: [symfony.com/doc/current/frontend/asset_mapper.html](https://symfony.com/doc/current/frontend/asset_mapper.html)
