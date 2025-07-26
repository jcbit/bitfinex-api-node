# 📦 Guía de Publicación Dual NPM

## 🎉 ¡Paquete Publicado en Ambos Registries!

El paquete **@jcbit/bitfinex-api-node** está ahora disponible en:

### 📍 **Ubicaciones de Publicación**

1. **🔒 GitHub Package Registry** (v7.1.0)

   - URL: https://github.com/users/jcbit/packages/npm/package/bitfinex-api-node
   - Requiere autenticación con GitHub

2. **🌐 npm público** (v7.1.1)
   - URL: https://www.npmjs.com/package/@jcbit/bitfinex-api-node
   - Acceso público sin autenticación

## 🚀 **Instalación según Registry**

### Para npm público (Recomendado para usuarios finales):

```bash
# Instalación simple - sin autenticación requerida
npm install @jcbit/bitfinex-api-node
```

### Para GitHub Packages (Requiere autenticación):

```bash
# Configurar registry
echo "@jcbit:registry=https://npm.pkg.github.com" >> ~/.npmrc
echo "//npm.pkg.github.com/:_authToken=TU_GITHUB_TOKEN" >> ~/.npmrc

# Instalar
npm install @jcbit/bitfinex-api-node
```

## 🔧 **Desarrollo: Publicar en Ambos**

### Opción 1: Script Automatizado

```bash
# Publicar nueva versión patch en ambos lugares
./publish-dual.sh patch

# Publicar nueva versión minor
./publish-dual.sh minor

# Publicar nueva versión major
./publish-dual.sh major
```

### Opción 2: Scripts NPM

```bash
# Solo en GitHub Packages
npm run publish:github

# Solo en npm público
npm run publish:npm

# En ambos lugares
npm run publish:both
```

### Opción 3: Manual

```bash
# 1. Actualizar versión
npm version patch

# 2. Publicar en GitHub
npm config set @jcbit:registry https://npm.pkg.github.com
npm publish

# 3. Publicar en npm público
npm config set @jcbit:registry https://registry.npmjs.org
npm publish --access public

# 4. Push cambios
git push --tags
```

## 📊 **Estado Actual**

| Registry            | Versión | Estado       | URL                                                                                  |
| ------------------- | ------- | ------------ | ------------------------------------------------------------------------------------ |
| **GitHub Packages** | v7.1.0  | ✅ Publicado | [Ver paquete](https://github.com/users/jcbit/packages/npm/package/bitfinex-api-node) |
| **npm público**     | v7.1.1  | ✅ Publicado | [Ver paquete](https://www.npmjs.com/package/@jcbit/bitfinex-api-node)                |

## 🔄 **Estrategia de Versionado**

Para mantener ambos registries sincronizados:

1. **Versiones idénticas**: Usar el script `publish-dual.sh`
2. **Versiones diferentes**: GitHub Packages tiende a ser más restrictivo
3. **Releases**: Crear releases en GitHub que correspondan a versiones npm

## 🎯 **Recomendaciones**

### **Para usuarios finales**:

- **Usar npm público** - Más fácil, sin autenticación
- Comando: `npm install @jcbit/bitfinex-api-node`

### **Para desarrolladores**:

- **Usar GitHub Packages** - Mejor integración con GitHub
- Acceso a código fuente y issues integrado

### **Para distribución**:

- **Publicar en ambos** - Máxima accesibilidad
- npm público para facilidad, GitHub para integración

## 📚 **Enlaces Útiles**

- **📦 npm público**: https://www.npmjs.com/package/@jcbit/bitfinex-api-node
- **🔒 GitHub Packages**: https://github.com/users/jcbit/packages/npm/package/bitfinex-api-node
- **🏠 Repositorio**: https://github.com/jcbit/bitfinex-api-node
- **🚀 Releases**: https://github.com/jcbit/bitfinex-api-node/releases

## 🔧 **Configuración de Desarrollo**

Para desarrollo local que soporte ambos registries:

```bash
# .npmrc para desarrollo
echo "registry=https://registry.npmjs.org" > .npmrc
echo "@jcbit:registry=https://registry.npmjs.org" >> .npmrc
```

Para switchear a GitHub Packages cuando sea necesario:

```bash
# Temporal para GitHub Packages
npm config set @jcbit:registry https://npm.pkg.github.com
```

## 🎉 **¡Listo para Usar!**

Tu paquete modernizado de Bitfinex API está ahora disponible en ambos registries principales de npm, ofreciendo máxima flexibilidad y accesibilidad para los usuarios.

---

**Última actualización**: Junio 24, 2025  
**Estado**: ✅ Dual publication activa  
**Próximo paso**: Mantener sincronización entre versiones
