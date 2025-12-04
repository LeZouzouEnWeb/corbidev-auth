# corbidev-auth

Projet d'authentification centralisée pour domaine et sous-domaines (SSO), basé sur Symfony 7, PHP 8, MariaDB, Tailwind CSS et SCSS.

## Objectifs

- Point unique pour inscription, connexion, gestion de compte.
- Accès cohérent depuis le domaine et les sous-domaines (SSO).
- Environnements: Développement et Homologation (staging).

## Stack & Décisions clés

- Backend: Symfony 7 (PHP 8), Doctrine ORM, MariaDB.
- SSO: OpenID Connect (Authorization Code Flow + PKCE).
- IdP: Keycloak (externe) sur `auth.<env>.corbisier.fr` (prod: `auth.corbisier.fr`, dev: `auth.dev-corbisier.fr`, homol: `auth.homol-corbisier.fr`).
- Frontend: Tailwind CSS (AssetMapper), SCSS pour overrides. Alternatives UI: Flowbite / daisyUI.
- Domaines: `*.corbisier.fr`, `dev-*.corbisier.fr`, `homol-*.corbisier.fr`.

## Documentation

- RAG principal: `docs/rag.md`
- Architecture détaillée: `docs/rag-02-architect-design.md`
- UI/UX (Tailwind+SCSS): `docs/rag-03-UI_UX_en-taiwling-css-et-chadcn.md`
- Fullstack (HTML/CSS/JS): `docs/rag-04-expert-fullstack-html-CSS-et-JS.md`
- Installation Backend: `docs/rag-05-installation-backend.md`

## Todo Liste — Suivi Projet

### Phase 1: Infrastructure & Configuration (En cours)

- [x] Créer structure de documentation (RAG)
- [x] Définir domaines et conventions (corbisier.fr)
- [x] Choisir IdP (Keycloak) et flux OIDC (Authorization Code + PKCE)
- [x] Créer `.env.example` et `.env.local` avec variables OIDC
- [x] Créer `compose.yml` (MariaDB + Adminer)
- [x] Lancer Docker Compose et vérifier Adminer accessible ([localhost:8080](http://localhost:8080))
- [ ] Installer Symfony 7 (`composer create-project symfony/skeleton:"7.0.*" ./`)
- [ ] Installer webapp pack (`composer require webapp`)
- [ ] Configurer `.env.local` avec DATABASE_URL locale
- [ ] Créer base de données (`php bin/console doctrine:database:create`)

### Phase 2: Backend — Entités & Migrations

- [ ] Installer ORM pack (`composer require symfony/orm-pack doctrine/migrations`)
- [ ] Créer entité `User` (`php bin/console make:user`)
  - Champs: email (unique), password, emailVerified, is2FAEnabled, locale, lastLogin, createdAt, updatedAt
- [ ] Créer entités complémentaires:
  - [ ] `Role` / `Permission` (RBAC)
  - [ ] `Session` (device, IP, userAgent, expiresAt)
  - [ ] `LoginAttempt` (IP, userId, success, timestamp)
  - [ ] `AuditLog` (event, userId, metadata, timestamp)
  - [ ] `Credential` (TOTP secret, codes de récupération)
- [ ] Générer migrations (`php bin/console make:migration`)
- [ ] Appliquer migrations (`php bin/console doctrine:migrations:migrate`)

### Phase 3: Sécurité & Authentification

- [ ] Installer bundles sécurité:
  - [ ] `composer require symfony/security-bundle`
  - [ ] `composer require symfony/password-hasher`
  - [ ] `composer require symfony/rate-limiter`
  - [ ] `composer require symfonycasts/verify-email-bundle`
- [ ] Configurer `security.yaml`:
  - [ ] Password hasher (Argon2id)
  - [ ] Firewalls
  - [ ] Access control
- [ ] Créer contrôleur `OidcController`:
  - [ ] Route `/oidc/login` (redirige vers Keycloak)
  - [ ] Route `/oidc/callback` (gère code + state)
  - [ ] Vérification PKCE et validation state

### Phase 4: Pages Auth & UI

- [ ] Installer AssetMapper + Sass:
  - [ ] `composer require symfony/asset-mapper`
  - [ ] `composer require symfonycasts/sass-bundle`
- [ ] Configurer Tailwind CSS (via AssetMapper)
- [ ] Créer templates Twig de base (layout, header, footer)
- [ ] Créer pages prioritaires:
  - [ ] Login
  - [ ] Registration (avec consentement CGU/Privacy)
  - [ ] Email Verification
  - [ ] Forgot Password
  - [ ] Reset Password
  - [ ] Profil utilisateur
- [ ] Intégrer Flowbite ou daisyUI pour composants UI

### Phase 5: Fonctionnalités Avancées

- [ ] Implémenter vérification email (avec liens signés expirables)
- [ ] Implémenter rate limiting (anti-bruteforce login)
- [ ] Préparer infrastructure 2FA TOTP:
  - [ ] Stockage secret TOTP dans `Credential`
  - [ ] UI activation/désactivation 2FA
  - [ ] Génération QR code
  - [ ] Codes de récupération
- [ ] Implémenter logout (local + SLO Keycloak si activé)
- [ ] Journalisation événements auth dans `AuditLog`

### Phase 6: Keycloak & Environnements

- [ ] Installer Keycloak (Docker ou service externe)
- [ ] Créer realm `demo` pour dev
- [ ] Configurer client OIDC dans Keycloak:
  - [ ] Type: Public (PKCE)
  - [ ] Redirect URIs: `https://app.dev-corbisier.fr/oidc/callback`
  - [ ] Scopes: `openid email profile`
- [ ] Tester flux complet dev:
  - [ ] Login via Keycloak
  - [ ] Callback et création session
  - [ ] Récupération claims (email, name, etc.)
  - [ ] Logout
- [ ] Préparer configuration homologation (`auth.homol-corbisier.fr`)
- [ ] Préparer configuration production (`auth.corbisier.fr`)

### Phase 7: Certificats & Proxy HTTPS

- [ ] Dev: installer `mkcert` et générer certificats multi-SAN (localhost + `*.dev-corbisier.fr`)
- [ ] Configurer reverse proxy dev (Nginx/Traefik/Caddy) avec HTTPS
- [ ] Homologation: configurer Let's Encrypt wildcard (`*.homol-corbisier.fr`) via DNS-01
- [ ] Configurer entêtes sécurité (HSTS, CSP, X-Content-Type-Options, Referrer-Policy)
- [ ] Tester cookies `Secure`, `HttpOnly`, `SameSite=None` inter-sous-domaines

### Phase 8: Tests & Validation

- [ ] Créer tests unitaires (User, services auth)
- [ ] Créer tests fonctionnels (pages login/register/callback)
- [ ] Tester parcours complet:
  - [ ] Registration + email verification
  - [ ] Login OIDC
  - [ ] Forgot/reset password
  - [ ] Profil modification
- [ ] Vérifier accessibilité (a11y) pages auth
- [ ] Vérifier responsiveness (mobile-first)
- [ ] Tests de charge (rate limiting, sessions concurrentes)

### Phase 9: Déploiement & Observabilité

- [ ] Préparer CI/CD (GitHub Actions / GitLab CI)
- [ ] Déployer environnement dev sur serveur/IONOS
- [ ] Déployer environnement homologation
- [ ] Configurer journaux centralisés (logs auth)
- [ ] Configurer alertes (pics d'échecs, IP suspectes)
- [ ] Documenter procédures de rotation des secrets (JWT, OIDC client_secret)
- [ ] Mettre en place sauvegardes DB

### Phase 10: Documentation & Formation

- [ ] Finaliser documentation technique (RAG complet)
- [ ] Créer guide d'onboarding développeurs
- [ ] Documenter procédures d'exploitation (déploiement, rollback, incidents)
- [ ] Former équipe sur flux OIDC et gestion Keycloak
- [ ] Préparer documentation utilisateur finale (FAQ, support)

## Démarrage rapide

### 1. Prérequis

- PHP 8.2+
- Composer
- Docker & Docker Compose
- Git

### 2. Cloner et configurer

```powershell
git clone <repo-url> corbidev-auth
cd corbidev-auth

# Copier et personnaliser .env.local
cp .env.example .env.local
# Éditer .env.local avec vos secrets et DB locale
```

### 3. Lancer Docker (MariaDB + Adminer)

```powershell
docker compose up -d
```

Adminer: [localhost:8080](http://localhost:8080)

### 4. Installer Symfony

```powershell
composer create-project symfony/skeleton:"7.0.*" ./
composer require webapp
composer require symfony/orm-pack doctrine/migrations
composer require symfony/asset-mapper symfonycasts/sass-bundle
```

### 5. Créer la base de données

```powershell
php bin/console doctrine:database:create
```

### 6. Lancer le serveur de développement

```powershell
php -S localhost:8000 -t public
```

Ou avec Symfony CLI:

```powershell
symfony serve
```

## Statut du Projet

**Phase actuelle**: Phase 1 — Infrastructure & Configuration (90% complété)

**Prochaine étape**: Lancer Docker Compose et installer Symfony 7

## Contributeurs

- Eric (Lead Developer)

## Licence

Projet privé — Tous droits réservés
