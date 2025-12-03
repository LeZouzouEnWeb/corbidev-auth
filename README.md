# corbidev-auth

Projet d'authentification centralisée pour domaine et sous-domaines (SSO), basé sur Symfony 7, PHP 8, MariaDB, Tailwind CSS et SCSS.

## Objectifs

- Point unique pour inscription, connexion, gestion de compte.
- Accès cohérent depuis le domaine et les sous-domaines (SSO).
- Environnements: Développement et Homologation (staging).

## Stack & Décisions clés

- Backend: Symfony 7 (PHP 8), Doctrine ORM, MariaDB.
- SSO: OpenID Connect (Authorization Code Flow + PKCE).
- IdP: recommandé externe (Keycloak / ORY Hydra). Alternative interne: OAuth2 via `trikoder/oauth2-bundle`.
- Frontend: Tailwind CSS (AssetMapper), SCSS pour overrides. Alternatives UI: Flowbite / daisyUI.

## Documentation

- RAG de connaissance: voir `docs/rag.md`.

## Démarrage (optionnel)

Ces commandes initialisent un squelette Symfony et les outils front:

```powershell
# Créer le squelette Symfony 7
composer create-project symfony/skeleton:"^7.0" .
composer require symfony/webapp-pack

# Frontend: AssetMapper + Sass
composer require symfony/asset-mapper
composer require symfonycasts/sass-bundle

# Base de données & migrations
composer require symfony/orm-pack doctrine/migrations
```

## Prochains pas

- Valider IdP (Keycloak/ORY) et config domaines (`auth.<env>.<domaine>`).
- Définir variables d'environnement et secrets (`APP_SECRET`, DSN, OIDC endpoints).
- Mettre en place proxy HTTPS (dev: mkcert; stg: Let's Encrypt wildcard).
- Scaffolder pages Auth (login/register/forgot), puis intégration OIDC.
