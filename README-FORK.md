# Bitfinex API Node - Fork by JCBit

Este es un fork mantenido por JCBit del cliente oficial de Bitfinex API para Node.js.

## 🚀 Desarrollo en Contenedor

Este proyecto está configurado para funcionar con DevContainers para un entorno de desarrollo consistente.

### Prerequisitos

- Docker y Docker Compose instalados
- VS Code con la extensión "Dev Containers"

### Inicio Rápido

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/JCBit/bitfinex-api-node.git
   cd bitfinex-api-node
   ```

2. **Abrir en DevContainer**:
   - Abrir VS Code en este directorio
   - Usar Command Palette (`Ctrl+Shift+P`) y seleccionar "Dev Containers: Reopen in Container"
   - O hacer clic en la notificación para reabrir en contenedor

3. **Configuración Automática**:
   - El contenedor se construirá automáticamente
   - Las dependencias se instalarán automáticamente
   - El entorno estará listo para usar

### Comandos Disponibles

- `npm test` - Ejecutar todos los tests
- `npm run lint` - Verificar el código con StandardJS
- `npm run lint:fix` - Corregir automáticamente problemas de linting
- `npm run docs` - Generar documentación JSDoc

### Configuración de API

1. Copia el archivo `.env.example` a `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edita `.env` con tus credenciales de Bitfinex:
   ```env
   API_KEY=tu_api_key_aqui
   API_SECRET=tu_api_secret_aqui
   ```

### Puertos Disponibles

- **3060**: Servidor principal de desarrollo
- **3061**: Puerto para testing
- **3062**: Puerto adicional para otros servicios

### Sincronización con el Repositorio Original

Para mantener tu fork actualizado con el repositorio original:

```bash
# Obtener cambios del repositorio original
git fetch upstream

# Fusionar cambios en tu rama main
git checkout main
git merge upstream/main

# Subir cambios a tu fork
git push origin main
```

## 📝 Diferencias con el Original

Documenta aquí las modificaciones que hagas al código original.

## 🤝 Contribuciones

Si encuentras bugs o mejoras, por favor crea un issue o pull request.

## 📄 Licencia

Mantiene la misma licencia que el proyecto original.

---

**Repositorio Original**: https://github.com/bitfinexcom/bitfinex-api-node
**Fork Mantenido por**: JCBit
