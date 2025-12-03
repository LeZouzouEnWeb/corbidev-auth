// app.js
// SOMBRE / CLAIR

(function () {
    const key = 'theme_pref';
    const root = document.documentElement;
    const btn = document.getElementById('themeToggle');

    // Apply saved preference (default dark if none)
    const saved = localStorage.getItem(key);
    if (saved) {
        root.setAttribute('data-bs-theme', saved);
    } else if (!root.getAttribute('data-bs-theme')) {
        root.setAttribute('data-bs-theme', 'dark');
    }

    if (btn) {
        btn.addEventListener('click', () => {
            const cur = root.getAttribute('data-bs-theme') || 'dark';
            const next = (cur === 'dark') ? 'light' : 'dark';
            root.setAttribute('data-bs-theme', next);
            localStorage.setItem(key, next);
        });
    }
})();

// (Rotation du token côté serveur)
