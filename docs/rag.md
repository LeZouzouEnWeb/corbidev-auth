# RAG de connaissance — Authentification centralisée (Symfony/MariaDB)

## Décisions d'architecture (résumé)

- IdP: Keycloak (OIDC) sur `auth.<env>.corbisier.fr` (prod: `auth.corbisier.fr`, dev: `auth.dev-corbisier.fr`, homol: `auth.homol-corbisier.fr`).
- Flux: Authorization Code + PKCE; `state` anti-CSRF, `nonce` pour ID Token.
- Domaines & cookies: wildcard `*.corbisier.fr`; cookies `Domain=.corbisier.fr` (prod), `.dev-corbisier.fr` (dev), `.homol-corbisier.fr` (homol), `Secure`, `HttpOnly`, `SameSite=None`.
- Backend: Symfony 7 (PHP 8), MariaDB (Doctrine ORM), proxy HTTPS (Nginx/Traefik/Caddy).
- Frontend: Tailwind CSS via AssetMapper + SCSS pour overrides; éviter Chakra (React), préférer Flowbite/daisyUI.

Références internes:
- Architecture détaillée: voir `docs/rag-02-architect-design.md`.
- UI/UX: voir `docs/rag-03-UI_UX_en-taiwling-css-et-chadcn.md`.
- Fullstack (HTML/CSS/JS): voir `docs/rag-04-expert-fullstack-html-CSS-et-JS.md`.


## Introduction

- Objectif: un point unique pour inscription, connexion, gestion de compte, valable pour le domaine et tous les sous-domaines.
- Périmètre: environnements Développement et Homologation (staging), stack Symfony 7, PHP 8, Composer, MariaDB, Tailwind CSS + SCSS, options CDN.

## Architecture

- Décision IdP: Keycloak comme fournisseur OIDC externe (recommandé) déployé sur `auth.<env>.<domaine>`. Alternative possible: ORY Hydra (OP OAuth2 + OIDC) si besoins plus modulaires.
- Motivation: conformité OIDC, gestion mature des sessions/consentements/2FA, maintenance et écosystème riches. Implémentation IdP interne en Symfony reste envisageable (OAuth2 via `trikoder/oauth2-bundle`), mais l'OIDC complet est complexe et plus risqué.
- Flux: OIDC Authorization Code Flow avec PKCE; sessions côté serveur pour les apps Symfony, tokens côté clients pour APIs.

## Cookies & Sécurité Navigateur

- Cookie de session partagé: `Domain=.exemple.com`, `Secure`, `HttpOnly`, `SameSite=None` pour SSO inter-sous-domaines.
- CSRF: paramètre `state` dans la requête d'autorisation; jetons CSRF pour formulaires/app.
- Redirections: toujours via HTTPS; gérer `X-Forwarded-*` derrière proxy.

## Bundles & Librairies (Symfony)

- OAuth2 serveur: `trikoder/oauth2-bundle` (League OAuth2 Server) — Doctrine/MariaDB.
- OIDC IdP: privilégier Keycloak/ORY Hydra (externe) pour conformité.
- Client OAuth2/OIDC: `knpuniversity/oauth2-client-bundle` ou config manuelle endpoints OIDC.
- JWT API: `lexik/jwt-authentication-bundle`; bas niveau: `lcobucci/jwt`.
- Sessions: `framework.session` (`symfony/http-foundation`).
- Hachage mots de passe: `symfony/password-hasher` (Argon2id/BCrypt).
- Vérification email: `symfonycasts/verify-email-bundle`.
- Limitation de débit: `symfony/rate-limiter`.
- Sécurité: `symfony/security-http`, `symfony/uid`, `symfony/notifier` (OTP).

## Modèle de Données (Doctrine/MariaDB)

- `users`: email unique, password hash, états (email_verified, 2FA_enabled), métadonnées.
- `credentials`/`auth_factors`: secrets TOTP, codes de récupération, (éventuel WebAuthn).
- `roles`/`permissions`: rôles → permissions; claims (`roles`, `groups`).
- `sessions`: device, IP, user-agent, expiration; invalidation à changement de mot de passe.
- OAuth2: `oauth_clients`, `authorization_codes`, `access_tokens`, `refresh_tokens` (PKCE `code_challenge`).
- `login_attempts`: par utilisateur/IP pour anti-bruteforce.
- `audit_logs`: événements (register, login, logout, consent, change_password, 2FA setup).
- Migrations: Doctrine Migrations ciblant MariaDB (`doctrine/dbal`, `doctrine/orm`).

## Environnements & Déploiement

- Conventions de domaines:
  - Modèle: `auth.<env>.<domaine>` pour l'IdP central; applications clientes sous `*.<env>.<domaine>`.
  - Production: `*.corbisier.fr` (IdP: `auth.corbisier.fr`).
  - Développement: `dev-*.corbisier.fr` (IdP: `auth.dev-corbisier.fr`).
  - Homologation: `homol-*.corbisier.fr` (IdP: `auth.homol-corbisier.fr`).
  - Cookies: utiliser `Domain=.corbisier.fr` en prod; `Domain=.dev-corbisier.fr` et `Domain=.homol-corbisier.fr` pour dev/homologation.
  - Certificats: wildcard conseillé pour prod `*.corbisier.fr`; pour dev/homologation, wildcard ou multi-SAN selon DNS.
- Variables d'environnement: `APP_SECRET`, DSN DB, clés JWT, secrets OIDC, endpoints (`OIDC_ISSUER`, `AUTHORIZATION_ENDPOINT`, `TOKEN_ENDPOINT`, `JWKS_URI`).
- Gestion des secrets: `.env.local` non commité; coffre (Key Vault/Secrets Manager).
- Certificats:
  - Dev: `mkcert` multi-SAN (localhost + sous-domaines).
  - Homologation: Let's Encrypt wildcard `*.stg.exemple.com` via DNS-01.
- Reverse proxy: Nginx/Traefik/Caddy — HTTPS, HSTS, HTTP/2, `SameSite=None + Secure`, cache assets.

## Frontend (Tailwind, SCSS, CDN)

- Tailwind CSS:
  - AssetMapper (Symfony 6/7): minimal setup, importmaps; ou Webpack Encore si TS/JSX.
- SCSS:
  - Utiliser Tailwind pour 80–90% (utilitaires); SCSS pour variables/mixins/overrides; via `symfonycasts/sass-bundle` ou `sass-loader` (Encore).
- Chakra UI:
  - Orienté React; usage via CDN en Twig peu naturel. Alternatives Tailwind-friendly: Flowbite (UI + JS), daisyUI (plugin Tailwind).

## Sécurité — Checklist

- Mots de passe: Argon2id, politique robuste, vérification contre listes compromises.
- 2FA/TOTP: activer TOTP (RFC 6238), codes de récupération; considérer WebAuthn.
- Vérification email: liens signés avec expiration; activation obligatoire.
- Anti-bruteforce: `symfony/rate-limiter` par IP/compte; captcha en dernier recours.
- Sessions: timeout d'inactivité, invalidation globale à changement de mot de passe.
- Tokens: durées courtes, scopes minimaux, refresh rotatif, PKCE obligatoire.
- Logs/monitoring: audit, alertes (tentatives, géo-IP), corrélation.
- Conformité: GDPR, minimisation, effacement, portabilité, registre des traitements.
- Headers: CSP (nonce/importmaps), HSTS, X-Content-Type-Options, Referrer-Policy.

## Parcours & UX

- Pages prioritaires: login, registration, email verification, forgot/reset, profil.
- Consentement: accepter les CGU/Privacy à l'inscription (journaliser l'acceptation avec version et horodatage).

## OIDC/OAuth2 — Proposition

- Scopes par défaut: `openid email profile`.
- Claims utiles: `email`, `email_verified`, `name`/`given_name`/`family_name`, `locale`, `roles` (si gestion de rôles côté IdP), option `tenant` si multi-tenant envisagé.
- Types de clients:
  - Public (PKCE) pour applications web front (impératif).
  - Confidentiel pour backends/services server-side (client_secret stocké côté serveur).
- Single Logout (SLO): activer SLO via Keycloak si besoin; sinon, commencer par logout applicatif et prévoir l'évolution.
- Flux: Authorization Code + PKCE systématique; `state` pour CSRF et `nonce` pour ID Token.

## Sécurité — Décisions

- Mots de passe: appliquer les normes actuelles (longueur minimale, vérification contre bases compromises type Pwned Passwords, hash Argon2id).
- 2FA: non obligatoire au départ; préparer l'activation TOTP ultérieure (stockage secret TOTP, codes de récupération, UI d'activation).

## Opérations & Observabilité

- Journaux: événements d'auth critiques, corrélation par session/utilisateur.
- Alertes: pics d'échecs, IP suspectes, anomalies de localisation.
- Rotation: secrets, clés JWT, certificats; procédures documentées.

## Références

- OIDC Core: [openid.net/specs/openid-connect-core-1_0.html](https://openid.net/specs/openid-connect-core-1_0.html)
- OAuth2 RFC 6749: [datatracker.ietf.org/doc/html/rfc6749](https://datatracker.ietf.org/doc/html/rfc6749)
- PKCE RFC 7636: [datatracker.ietf.org/doc/html/rfc7636](https://datatracker.ietf.org/doc/html/rfc7636)
- Symfony AssetMapper: [symfony.com/doc/current/frontend/asset_mapper.html](https://symfony.com/doc/current/frontend/asset_mapper.html)
- Symfony Encore: [symfony.com/doc/current/frontend/encore/installation.html](https://symfony.com/doc/current/frontend/encore/installation.html)
- Keycloak docs: [keycloak.org/documentation](https://www.keycloak.org/documentation)
- ORY Hydra docs: [ory.com/docs/hydra](https://www.ory.com/docs/hydra/)
- Tailwind install: [tailwindcss.com/docs/installation](https://tailwindcss.com/docs/installation)
- Flowbite: [flowbite.com/docs/getting-started/introduction](https://flowbite.com/docs/getting-started/introduction/)
- daisyUI: [daisyui.com/docs/install](https://daisyui.com/docs/install/)
- mkcert: [github.com/FiloSottile/mkcert](https://github.com/FiloSottile/mkcert)
- Cookies SameSite: [developer.mozilla.org/.../SameSite](https://developer.mozilla.org/fr/docs/Web/HTTP/Headers/Set-Cookie/SameSite)
- CSP importmaps: [symfony.com/.../asset_mapper.html#using-a-content-security-policy-csp](https://symfony.com/doc/current/frontend/asset_mapper.html#using-a-content-security-policy-csp)

## Configuration

- Fichier d’exemple: voir `/.env.example` et créer vos secrets dans `/.env.local` (non commités).
- Variables OIDC (Keycloak):
  - `OIDC_ISSUER`: base URL de l’issuer (realm), ex: `https://auth.dev-corbisier.fr/realms/<realm>`
  - `AUTHORIZATION_ENDPOINT`: ex: `.../protocol/openid-connect/auth`
  - `TOKEN_ENDPOINT`: ex: `.../protocol/openid-connect/token`
  - `JWKS_URI`: ex: `.../protocol/openid-connect/certs`
  - `USERINFO_ENDPOINT` (optionnel): ex: `.../protocol/openid-connect/userinfo`
  - `OIDC_CLIENT_ID`, `OIDC_CLIENT_SECRET`: identifiants client (stocker le secret côté serveur uniquement)
  - `OIDC_REDIRECT_URI`: URI de callback, ex: `https://app.dev-corbisier.fr/oidc/callback`
  - `OIDC_SCOPES`: `openid email profile`
- Sessions/cookies:
  - `SESSION_COOKIE_DOMAIN`: `.corbisier.fr` (prod), `.dev-corbisier.fr` (dev), `.homol-corbisier.fr` (homol)
  - `SESSION_COOKIE_SECURE=true`, `SESSION_COOKIE_SAMESITE=none`
- Base de données app: `DATABASE_URL` (MariaDB).
- Mail: `MAILER_DSN` pour emails de vérification.

### .env.local (dev)

- Fichier local non commité: créez `/.env.local` sur votre machine pour surcharger `/.env.example`.
- Personnalisation typique en dev:
  - `SESSION_COOKIE_DOMAIN=.dev-corbisier.fr`
  - `OIDC_ISSUER` et endpoints pointant vers `auth.dev-corbisier.fr` (realm de test)
  - `OIDC_CLIENT_ID`/`OIDC_CLIENT_SECRET` de client dev
  - `DATABASE_URL` vers MariaDB locale (docker ou service)
  - `MAILER_DSN` vers MailHog/SMTP local
