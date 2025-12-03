# Suivi — Auth-Env (nom non trouvé)

**Date d'initialisation :** 2025-09-22 07:59

## Contexte

- Projet d’authentification multi-environnements (DEV / HOMOL / PROD).
- Périmètre : API d’authentification, rôles/droits, journaux d’audit, sécurité renforcée.

## Versions & dépendances clés

- PHP requis : `8.3`

## Architecture (résumé)
## Endpoints publics (URL)
> Le **DocumentRoot** pointe sur `auth/public/`, donc les endpoints s’appellent **à la racine** du domaine :

- `/logger_test.php` — test Monolog (écrit canal + console)
- `/debug-console.php` — console de logs (ouvrir/réduire/copier/télécharger/clear)
- `/token_issue.php` — émission JWT
- `/token_verify.php` — vérification JWT (Authorization: Bearer …)
- `/migrate.php?file=YYYY_MM_DD.sql` — exécuter une migration (logs dans `logs/migration_*.log`)

- `auth/` (156 fichiers)

## Arborescence (vue détaillée)

```text
📁 auth/
  └─ 📄 .env.example  (931 o)
  └─ 📄 app.json  (353 o)
  └─ 📄 composer.json  (298 o)
  └─ 📄 composer.lock  (4126 o)
  📁 auth/db/
    📁 auth/db/migrations/
      └─ 📄 2025_09_18_phase6_fix.sql  (0 o)
  📁 auth/docs/
    └─ 📄 .env.example  (581 o)
    └─ 📄 README_APPLY.txt  (481 o)
    └─ 📄 README_LOGIN_VIEW.md  (276 o)
    └─ 📄 README_P3.md  (1071 o)
    └─ 📄 app.json.additions.sample.json  (247 o)
  📁 auth/logs/
    └─ 📄 migration.log  (1734 o)
    └─ 📄 php_error.log  (1095 o)
  📁 auth/public/
    └─ 📄 .htaccess  (285 o)
    └─ 📄 favicon.svg  (378 o)
    └─ 📄 index.php  (267 o)
    └─ 📄 logo.svg  (378 o)
    └─ 📄 migrate.php  (3957 o)
    📁 auth/public/assets/
      📁 auth/public/assets/css/
        └─ 📄 auth_src_App_Http_views_home_php.css  (314 o)
        └─ 📄 auth_src_App_Http_views_login_php.css  (573 o)
        └─ 📄 auth_src_App_Http_views_partials_debug-env_php.css  (571 o)
        └─ 📄 auth_src_App_Http_views_partials_debug_php.css  (2929 o)
        └─ 📄 auth_src_App_Http_views_partials_header_php.css  (88 o)
        └─ 📄 auth_src_App_Http_views_reset_invalid_php.css  (280 o)
        └─ 📄 auth_src_App_Http_views_reset_php.css  (313 o)
        └─ 📄 auth_src_App_Http_views_users_php.css  (815 o)
      📁 auth/public/assets/js/
        └─ 📄 app-util.js  (1758 o)
        └─ 📄 auth_src_App_Http_views_account_php.js  (2286 o)
        └─ 📄 auth_src_App_Http_views_home_php.js  (3846 o)
        └─ 📄 auth_src_App_Http_views_login_php.js  (14186 o)
        └─ 📄 auth_src_App_Http_views_partials_debug-panel_php.js  (3002 o)
        └─ 📄 auth_src_App_Http_views_partials_debug_php.js  (8913 o)
        └─ 📄 auth_src_App_Http_views_partials_header_php.js  (675 o)
        └─ 📄 auth_src_App_Http_views_reset_invalid_php.js  (411 o)
        └─ 📄 auth_src_App_Http_views_reset_php.js  (2739 o)
        └─ 📄 auth_src_App_Http_views_users_php.js  (2981 o)
  📁 auth/src/
    └─ 📄 bootstrap.php  (416 o)
    📁 auth/src/App/
      📁 auth/src/App/Http/
        └─ 📄 Router.php  (32496 o)
        📁 auth/src/App/Http/views/
          └─ 📄 account.php  (3107 o)
          └─ 📄 home.php  (1378 o)
          └─ 📄 login.php  (5804 o)
          └─ 📄 reset.php  (1929 o)
          └─ 📄 reset_invalid.php  (1061 o)
          └─ 📄 users.php  (6283 o)
          📁 auth/src/App/Http/views/partials/
            └─ 📄 debug-console.php  (3067 o)
            └─ 📄 debug-env.php  (571 o)
            └─ 📄 debug-panel.php  (4434 o)
            └─ 📄 debug.php  (3067 o)
            └─ 📄 footer.php  (930 o)
            └─ 📄 head.php  (1559 o)
            └─ 📄 header.php  (734 o)
            └─ 📄 info-connect.php  (387 o)
            └─ 📄 nav.php  (1506 o)
      📁 auth/src/App/Services/
        └─ 📄 AccountService.php  (345 o)
        └─ 📄 AdminCreationMailer.php  (2640 o)
        └─ 📄 AppConfig.php  (898 o)
        └─ 📄 Config.php  (257 o)
        └─ 📄 Database.php  (878 o)
        └─ 📄 Env.php  (1011 o)
        └─ 📄 EnvAccessService.php  (1627 o)
        └─ 📄 ExpiryMailer.php  (2791 o)
        └─ 📄 LoginAttemptRepository.php  (2421 o)
        └─ 📄 Mailer.php  (3937 o)
        └─ 📄 ResetLogger.php  (304 o)
        └─ 📄 ResetTokenRepository.php  (1846 o)
        └─ 📄 Security.php  (678 o)
        └─ 📄 SessionService.php  (1721 o)
        └─ 📄 TokenService.php  (2030 o)
        └─ 📄 UnlockMailer.php  (1940 o)
        └─ 📄 Url.php  (985 o)
        └─ 📄 UserCreator.php  (1265 o)
        └─ 📄 UserDeletionService.php  (1986 o)
        └─ 📄 UserRepository.php  (11524 o)
  📁 auth/vendor/
    └─ 📄 autoload.php  (748 o)
    📁 auth/vendor/composer/
      └─ 📄 ClassLoader.php  (16378 o)
      └─ 📄 InstalledVersions.php  (17395 o)
      └─ 📄 LICENSE  (1070 o)
      └─ 📄 autoload_classmap.php  (1844 o)
      └─ 📄 autoload_namespaces.php  (139 o)
      └─ 📄 autoload_psr4.php  (258 o)
      └─ 📄 autoload_real.php  (1137 o)
      └─ 📄 autoload_static.php  (3112 o)
      └─ 📄 installed.json  (3767 o)
      └─ 📄 installed.php  (1054 o)
      └─ 📄 platform_check.php  (917 o)
    📁 auth/vendor/phpmailer/
      📁 auth/vendor/phpmailer/phpmailer/
        └─ 📄 COMMITMENT  (2092 o)
        └─ 📄 LICENSE  (26529 o)
        └─ 📄 README.md  (16832 o)
        └─ 📄 SECURITY.md  (7585 o)
        └─ 📄 SMTPUTF8.md  (5915 o)
        └─ 📄 VERSION  (7 o)
        └─ 📄 composer.json  (2775 o)
        └─ 📄 get_oauth_token.php  (6261 o)
        📁 auth/vendor/phpmailer/phpmailer/language/
          └─ 📄 phpmailer.lang-af.php  (1584 o)
          └─ 📄 phpmailer.lang-ar.php  (2024 o)
          └─ 📄 phpmailer.lang-as.php  (3792 o)
          └─ 📄 phpmailer.lang-az.php  (1749 o)
          └─ 📄 phpmailer.lang-ba.php  (1745 o)
          └─ 📄 phpmailer.lang-be.php  (2178 o)
          └─ 📄 phpmailer.lang-bg.php  (2196 o)
          └─ 📄 phpmailer.lang-bn.php  (3845 o)
          └─ 📄 phpmailer.lang-ca.php  (1730 o)
          └─ 📄 phpmailer.lang-cs.php  (1798 o)
          └─ 📄 phpmailer.lang-da.php  (2409 o)
          └─ 📄 phpmailer.lang-de.php  (1886 o)
          └─ 📄 phpmailer.lang-el.php  (3307 o)
          └─ 📄 phpmailer.lang-eo.php  (1665 o)
          └─ 📄 phpmailer.lang-es.php  (2588 o)
          └─ 📄 phpmailer.lang-et.php  (1744 o)
          └─ 📄 phpmailer.lang-fa.php  (2079 o)
          └─ 📄 phpmailer.lang-fi.php  (1659 o)
          └─ 📄 phpmailer.lang-fo.php  (1637 o)
          └─ 📄 phpmailer.lang-fr.php  (2732 o)
          └─ 📄 phpmailer.lang-gl.php  (1742 o)
          └─ 📄 phpmailer.lang-he.php  (1812 o)
          └─ 📄 phpmailer.lang-hi.php  (3768 o)
          └─ 📄 phpmailer.lang-hr.php  (1754 o)
          └─ 📄 phpmailer.lang-hu.php  (1717 o)
          └─ 📄 phpmailer.lang-hy.php  (2185 o)
          └─ 📄 phpmailer.lang-id.php  (1997 o)
          └─ 📄 phpmailer.lang-it.php  (1819 o)
          └─ 📄 phpmailer.lang-ja.php  (2934 o)
          └─ 📄 phpmailer.lang-ka.php  (2884 o)
          └─ 📄 phpmailer.lang-ko.php  (1771 o)
          └─ 📄 phpmailer.lang-ku.php  (2238 o)
          └─ 📄 phpmailer.lang-lt.php  (1627 o)
          └─ 📄 phpmailer.lang-lv.php  (1643 o)
          └─ 📄 phpmailer.lang-mg.php  (1782 o)
          └─ 📄 phpmailer.lang-mn.php  (2186 o)
          └─ 📄 phpmailer.lang-ms.php  (1734 o)
          └─ 📄 phpmailer.lang-nb.php  (2288 o)
          └─ 📄 phpmailer.lang-nl.php  (2365 o)
          └─ 📄 phpmailer.lang-pl.php  (2635 o)
          └─ 📄 phpmailer.lang-pt.php  (2465 o)
          └─ 📄 phpmailer.lang-pt_br.php  (2719 o)
          └─ 📄 phpmailer.lang-ro.php  (2448 o)
          └─ 📄 phpmailer.lang-ru.php  (3297 o)
          └─ 📄 phpmailer.lang-si.php  (3425 o)
          └─ 📄 phpmailer.lang-sk.php  (1909 o)
          └─ 📄 phpmailer.lang-sl.php  (2577 o)
          └─ 📄 phpmailer.lang-sr.php  (2301 o)
          └─ 📄 phpmailer.lang-sr_latn.php  (1814 o)
          └─ 📄 phpmailer.lang-sv.php  (1610 o)
          └─ 📄 phpmailer.lang-tl.php  (1721 o)
          └─ 📄 phpmailer.lang-tr.php  (2606 o)
          └─ 📄 phpmailer.lang-uk.php  (2282 o)
          └─ 📄 phpmailer.lang-ur.php  (2265 o)
          └─ 📄 phpmailer.lang-vi.php  (1793 o)
          └─ 📄 phpmailer.lang-zh.php  (1669 o)
          └─ 📄 phpmailer.lang-zh_cn.php  (2333 o)
        📁 auth/vendor/phpmailer/phpmailer/src/
          └─ 📄 DSNConfigurator.php  (6883 o)
          └─ 📄 Exception.php  (1256 o)
          └─ 📄 OAuth.php  (3791 o)
          └─ 📄 OAuthTokenProvider.php  (1538 o)
          └─ 📄 PHPMailer.php  (187770 o)
          └─ 📄 POP3.php  (12352 o)
          └─ 📄 SMTP.php  (50097 o)
```

## Fichiers et rôles (initial)

Ce tableau est initialisé automatiquement. Les rôles doivent être validés/ajustés.

| Chemin | Taille (o) | Rôle (déduction) |
|---|---:|---|
| `auth/.env.example` | 931 | Variables d'environnement |
| `auth/app.json` | 353 | Définition des rôles/règles d'accès |
| `auth/composer.json` | 298 | Configuration Composer (dépendances et scripts) |
| `auth/composer.lock` | 4126 | Verrouillage des versions Composer |
| `auth/db/migrations/2025_09_18_phase6_fix.sql` | 0 | Migration base de données / SQL |
| `auth/docs/.env.example` | 581 | Variables d'environnement |
| `auth/docs/README_APPLY.txt` | 481 | À préciser |
| `auth/docs/README_LOGIN_VIEW.md` | 276 | Documentation |
| `auth/docs/README_P3.md` | 1071 | Documentation |
| `auth/docs/app.json.additions.sample.json` | 247 | Définition des rôles/règles d'accès |
| `auth/logs/migration.log` | 1734 | Logs applicatifs |
| `auth/logs/php_error.log` | 1095 | Logs applicatifs |
| `auth/public/.htaccess` | 285 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_home_php.css` | 314 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_login_php.css` | 573 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_partials_debug-env_php.css` | 571 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_partials_debug_php.css` | 2929 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_partials_header_php.css` | 88 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_reset_invalid_php.css` | 280 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_reset_php.css` | 313 | À préciser |
| `auth/public/assets/css/auth_src_App_Http_views_users_php.css` | 815 | À préciser |
| `auth/public/assets/js/app-util.js` | 1758 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_account_php.js` | 2286 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_home_php.js` | 3846 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_login_php.js` | 14186 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_partials_debug-panel_php.js` | 3002 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_partials_debug_php.js` | 8913 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_partials_header_php.js` | 675 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_reset_invalid_php.js` | 411 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_reset_php.js` | 2739 | À préciser |
| `auth/public/assets/js/auth_src_App_Http_views_users_php.js` | 2981 | À préciser |
| `auth/public/favicon.svg` | 378 | À préciser |
| `auth/public/index.php` | 267 | Point d'entrée HTTP (front controller) |
| `auth/public/logo.svg` | 378 | À préciser |
| `auth/public/migrate.php` | 3957 | Script public (endpoint/outil accessible web) |
| `auth/src/App/Http/Router.php` | 32496 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/account.php` | 3107 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/home.php` | 1378 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/login.php` | 5804 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/debug-console.php` | 3067 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/debug-env.php` | 571 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/debug-panel.php` | 4434 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/debug.php` | 3067 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/footer.php` | 930 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/head.php` | 1559 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/header.php` | 734 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/info-connect.php` | 387 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/partials/nav.php` | 1506 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/reset.php` | 1929 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/reset_invalid.php` | 1061 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Http/views/users.php` | 6283 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/AccountService.php` | 345 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/AdminCreationMailer.php` | 2640 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/AppConfig.php` | 898 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Config.php` | 257 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Database.php` | 878 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Env.php` | 1011 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/EnvAccessService.php` | 1627 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/ExpiryMailer.php` | 2791 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/LoginAttemptRepository.php` | 2421 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Mailer.php` | 3937 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/ResetLogger.php` | 304 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/ResetTokenRepository.php` | 1846 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Security.php` | 678 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/SessionService.php` | 1721 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/TokenService.php` | 2030 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/UnlockMailer.php` | 1940 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/Url.php` | 985 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/UserCreator.php` | 1265 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/UserDeletionService.php` | 1986 | Code source PHP (services, classes, logique métier) |
| `auth/src/App/Services/UserRepository.php` | 11524 | Code source PHP (services, classes, logique métier) |
| `auth/src/bootstrap.php` | 416 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/autoload.php` | 748 | Dépendances tierces (Composer) |
| `auth/vendor/composer/ClassLoader.php` | 16378 | Dépendances tierces (Composer) |
| `auth/vendor/composer/InstalledVersions.php` | 17395 | Dépendances tierces (Composer) |
| `auth/vendor/composer/LICENSE` | 1070 | Dépendances tierces (Composer) |
| `auth/vendor/composer/autoload_classmap.php` | 1844 | Dépendances tierces (Composer) |
| `auth/vendor/composer/autoload_namespaces.php` | 139 | Dépendances tierces (Composer) |
| `auth/vendor/composer/autoload_psr4.php` | 258 | Dépendances tierces (Composer) |
| `auth/vendor/composer/autoload_real.php` | 1137 | Dépendances tierces (Composer) |
| `auth/vendor/composer/autoload_static.php` | 3112 | Dépendances tierces (Composer) |
| `auth/vendor/composer/installed.json` | 3767 | Dépendances tierces (Composer) |
| `auth/vendor/composer/installed.php` | 1054 | Dépendances tierces (Composer) |
| `auth/vendor/composer/platform_check.php` | 917 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/COMMITMENT` | 2092 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/LICENSE` | 26529 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/README.md` | 16832 | Documentation |
| `auth/vendor/phpmailer/phpmailer/SECURITY.md` | 7585 | Documentation |
| `auth/vendor/phpmailer/phpmailer/SMTPUTF8.md` | 5915 | Documentation |
| `auth/vendor/phpmailer/phpmailer/VERSION` | 7 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/composer.json` | 2775 | Configuration Composer (dépendances et scripts) |
| `auth/vendor/phpmailer/phpmailer/get_oauth_token.php` | 6261 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-af.php` | 1584 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ar.php` | 2024 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-as.php` | 3792 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-az.php` | 1749 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ba.php` | 1745 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-be.php` | 2178 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-bg.php` | 2196 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-bn.php` | 3845 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ca.php` | 1730 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-cs.php` | 1798 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-da.php` | 2409 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-de.php` | 1886 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-el.php` | 3307 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-eo.php` | 1665 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-es.php` | 2588 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-et.php` | 1744 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-fa.php` | 2079 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-fi.php` | 1659 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-fo.php` | 1637 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-fr.php` | 2732 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-gl.php` | 1742 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-he.php` | 1812 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-hi.php` | 3768 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-hr.php` | 1754 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-hu.php` | 1717 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-hy.php` | 2185 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-id.php` | 1997 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-it.php` | 1819 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ja.php` | 2934 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ka.php` | 2884 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ko.php` | 1771 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ku.php` | 2238 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-lt.php` | 1627 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-lv.php` | 1643 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-mg.php` | 1782 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-mn.php` | 2186 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ms.php` | 1734 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-nb.php` | 2288 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-nl.php` | 2365 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-pl.php` | 2635 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-pt.php` | 2465 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-pt_br.php` | 2719 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ro.php` | 2448 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ru.php` | 3297 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-si.php` | 3425 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-sk.php` | 1909 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-sl.php` | 2577 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-sr.php` | 2301 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-sr_latn.php` | 1814 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-sv.php` | 1610 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-tl.php` | 1721 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-tr.php` | 2606 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-uk.php` | 2282 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-ur.php` | 2265 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-vi.php` | 1793 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-zh.php` | 1669 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/language/phpmailer.lang-zh_cn.php` | 2333 | Dépendances tierces (Composer) |
| `auth/vendor/phpmailer/phpmailer/src/DSNConfigurator.php` | 6883 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/Exception.php` | 1256 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/OAuth.php` | 3791 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/OAuthTokenProvider.php` | 1538 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/PHPMailer.php` | 187770 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/POP3.php` | 12352 | Code source PHP (services, classes, logique métier) |
| `auth/vendor/phpmailer/phpmailer/src/SMTP.php` | 50097 | Code source PHP (services, classes, logique métier) |

## Conventions & sécurité (rappel)

- `API_GATEWAY` défini et vérifié en entrée ; messages d’échec neutres.
- Cookies sécurisés (HttpOnly, Secure, SameSite).
- Logs d’audit activés hors PROD pour les actions sensibles.
- Développement en **mode plugin** ; éviter de modifier le cœur sans nécessité.

\1| 2025-09-22 09:19 | `auth/docs/suivi_auth_env.md` | 24381 | 24854 | Documentation | Correction des URLs publiques (docroot=public) + section Endpoints |
| 2025-09-22 09:07 | `auth/src/App/Services/MonologLoggerFactory.php` | (anc.) | (mod.) | Logs | Ajout handlers console (fichier partagé + STDOUT) activés en dev |

| 2025-09-22 07:59 | `docs/suivi_auth_env.md` | – | – | Suivi | Initialisation du suivi |


## Logs — Console partagée (dev)
- Activer via `.env` : `APP_ENV=dev` ou `APP_DEBUG=1`  
- Fichier console : `{LOG_DIR}/{CONSOLE_LOG_FILENAME|debug-console.log}`  
- Ouvrir l’UI : `/debug-console.php`  
- Tous les loggers créés via `MonologLoggerFactory::create(...)` écrivent automatiquement dans la console **et** dans leur fichier par canal (rotation).  


## Journal des modifications

| Date | Fichier | Ancien poids | Nouveau poids | Élément impacté | Motif |
|---|---|---:|---:|---|---|
| 2025-09-22 09:32 | `auth/composer.json` | (anc.) | (mod.) | Dépendances | Ajout `bramus/router` |
| 2025-09-22 09:32 | `auth/public/index.php` | (anc.) | (mod.) | Router | Intégration Bramus Router + routes `/token/*` `/logger/test` |
| 2025-09-22 09:32 | `auth/public/.htaccess` | – | (nouveau) | Router | Front controller Apache (garde fichiers existants) |


## Router (Bramus) — Endpoints
- `GET /` → Health
- `POST /token/issue` → Émission JWT (`sub`, `ttl`, `scope` en JSON)
- `GET /token/verify` → Vérification JWT (header `Authorization: Bearer …`)
- `GET /logger/test` → Test logs (écrit canal + console)

ℹ️ Les anciens fichiers publics (`token_issue.php`, `token_verify.php`, `logger_test.php`) restent fonctionnels.  
Le `.htaccess` sert de front controller : les fichiers **existants** sont servis tels quels ; le reste passe par `index.php`.
| 2025-09-22 14:50 | `auth/src/App/bootstrap.php` | (mod.) | (mod.) | Router | Suppression basePath (public = racine) |
| 2025-09-22 14:50 | `auth/templates/auth/login.html.twig` | (mod.) | (mod.) | UI | action du formulaire → `/login` |
| 2025-09-22 14:50 | `auth/src/App/Controllers/LoginController.php` | (mod.) | (mod.) | Auth | Redirection post-login vers `/` |

- 2025-09-22 — Ajout page d'accueil, menu accessible, favicons, assets CSS/JS, services Config/View. Fichiers modifiés: templates/base.html.twig, src/App/bootstrap.php. Fichiers créés: config/app.json, templates/partials/_nav.html.twig, templates/views/home.html.twig, public/assets/css/app.css, public/assets/js/app.js, public/favicon.ico, public/favicon.svg, public/logo.svg, src/App/Services/ConfigService.php, src/App/Services/ViewService.php.

## 2025-09-22 15:28
- Fichier modifié : `auth/config/app.json`
  - Ancien : contenait la clé `"env"`
  - Nouveau : suppression de `"env"` (l'ENV reste géré via `.env`)
  - Impact : aucun changement sur le rendu, le H1 reste défini par `title_h1`


---
**2025-09-25 05:36:20** — *Modification*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Taille : 2618 bytes (ancien : 1181 bytes)
- Impact : Priorité de chargement `.env.dev` > `.env` (safeLoad), idempotence, PHPDoc ajoutés, early return, pas de régression si Dotenv absent.

---
**2025-09-25 05:41:08** — *Modification*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Impact : Utilisation de `overload()` pour `.env.dev` afin de forcer la priorité même si des variables existent déjà (Apache/ENV).

---
**2025-09-25 05:43:30** — *Correction*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Contexte : Erreur `Call to undefined method Dotenv\Dotenv::overload()` (phpdotenv v5).
- Solution : utilisation de `RepositoryBuilder` **mutable** pour `.env.dev` (écrase), et **immutable** + `safeLoad()` pour `.env` (complète sans écraser).

---
**2025-09-25 05:48:41** — *Correction v2*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Contexte : `.env.dev` identique à `.env` mais non pris en compte.
- Solution : usage direct de `Dotenv::createMutable(...)->load()` pour `.env.dev` (override garanti), puis `createImmutable(...)->safeLoad()` pour `.env`.


---
**2025-09-25 05:54:07** — *Amélioration debug*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Ajouts : support emplacements `config/` **et** racine, liste des fichiers chargés (`filesLoaded()`), log debug conditionnel (`APP_DEBUG=1`).

---
**2025-09-25 05:58:25** — *Correction duplication propriété*
- Fichier : `src/App/Services/EnvDotenvBridge.php`
- Détail : réécriture propre (une seule propriété `$booted`), priorité `.env.dev` (mutable) puis `.env` (safeLoad), debug `filesLoaded()`.
- Taille : 3715 bytes (ancien : 4088 bytes)
