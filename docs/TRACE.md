# TRACE — Ajout moteur de templates Twig (dossier auth/)

## 2025-09-22
### Ajouts
- **auth/composer.json** : ajout dépendance `twig/twig:^3.10`
- **auth/src/App/Services/Twig/TwigFactory.php**
- **auth/src/App/Services/Twig/TwigRenderer.php**
- **auth/templates/** (base, partials, demo)
- **auth/public/demo_twig.php**
- **auth/cache/twig/** (dossier de cache prêt, activé seulement en PROD)

### Utilité
- Mise en place d’un moteur de rendu **Twig** standardisé sans dossier `dev/`.
- Respect des conventions projet : services isolés, index minimal, compatibilité Composer.
- Sécurité : autoescape HTML activé, constante `API_GATEWAY`.
