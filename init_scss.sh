#!/usr/bin/env bash

set -e


echo "📦 Installation Symfony 7"

php ~/serveur/conf/composer.phar create-project symfony/skeleton:"^7" symfony

cd symfony

echo "📦 Installation des modules webapp"

php ~/serveur/conf/composer.phar require webapp


echo "📦 Installation Webpack Encore + Tailwind + Sass + shadcn…"

#################################
# 1. PACKAGES PHP / WEBPACK
#################################

php ~/serveur/conf/composer.phar require symfony/webpack-encore-bundle

if [ ! -f package.json ]; then
  npm init -y
fi

npm install \
  @symfony/webpack-encore \
  sass \
  postcss postcss-loader autoprefixer \
  tailwindcss \
  --save-dev

#################################
# 2. INSTALLATION SHADCN (VERSION WEBPACK)
#################################
npm install class-variance-authority clsx tailwind-merge lucide --save

#################################
# 3. INITIALISATION TAILWIND
#################################

npx tailwindcss init -p

#################################
# 4. CONFIG POSTCSS
#################################

cat > postcss.config.js <<'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
EOF

#################################
# 5. CONFIG TAILWIND
#################################

cat > tailwind.config.js <<'EOF'
module.exports = {
  content: [
    "./templates/**/*.html.twig",
    "./assets/**/*.js",
    "./assets/**/*.scss",
    "./assets/components/**/*.{js,jsx,ts,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

#################################
# 6. ASSETS STRUCTURE
#################################

mkdir -p assets/styles
mkdir -p assets/components/ui

#################################
# 7. app.scss
#################################

cat > assets/styles/app.scss <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Place tes variables SCSS ici */
EOF

#################################
# 8. app.js
#################################

cat > assets/app.js <<'EOF'
import './styles/app.scss';
EOF

#################################
# 9. SHADCN EXAMPLE COMPONENT
#################################

cat > assets/components/ui/button.js <<'EOF'
import { cva } from "class-variance-authority";

export const button = cva(
  "px-4 py-2 rounded-md font-medium shadow-sm transition",
  {
    variants: {
      variant: {
        default: "bg-black text-white hover:bg-gray-800",
        outline: "border border-gray-300 text-gray-700 hover:bg-gray-100",
      },
      size: {
        sm: "text-sm",
        md: "text-base",
        lg: "text-lg",
      }
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    }
  }
);
EOF

#################################
# 10. Update webpack.config.js
#################################

if ! grep -q "enableSassLoader" webpack.config.js; then
  sed -i "s/Encore();/Encore().enableSassLoader().enablePostCssLoader();/" webpack.config.js
fi

echo "✅ Installation terminée !"
echo "➡ Lance : npm run dev --watch"