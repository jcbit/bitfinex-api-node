#!/bin/bash

# Script para publicar en múltiples registries
# Uso: ./publish-dual.sh [versión]

set -e

VERSION=${1:-"patch"}

echo "🚀 Publicación dual en GitHub Packages y npm público"

# 1. Hacer bump de versión
echo "📝 Actualizando versión..."
npm version $VERSION --no-git-tag-version

# 2. Obtener nueva versión
NEW_VERSION=$(node -p "require('./package.json').version")
echo "📦 Nueva versión: $NEW_VERSION"

# 3. Commit y tag
git add package.json
git commit -m "🔖 Bump version to $NEW_VERSION"
git tag "v$NEW_VERSION"

# 4. Publicar en GitHub Packages
echo "📦 Publicando en GitHub Packages..."
npm config set @jcbit:registry https://npm.pkg.github.com
npm publish --registry https://npm.pkg.github.com

# 5. Publicar en npm público
echo "🌐 Publicando en npm público..."
npm config set @jcbit:registry https://registry.npmjs.org
npm publish --registry https://registry.npmjs.org --access public

# 6. Push cambios
echo "🔄 Pusheando cambios..."
git push origin master --tags

echo "✅ Publicación completada en ambos registries!"
echo "📦 GitHub Packages: https://github.com/users/jcbit/packages/npm/package/bitfinex-api-node"
echo "🌐 npm público: https://www.npmjs.com/package/@jcbit/bitfinex-api-node"
