# Configuración de Variables de Entorno

Este archivo explica cómo configurar las variables de entorno para usar los ejemplos del proyecto bitfinex-api-node.

## 📋 Configuración Rápida

1. **Copia el archivo de ejemplo:**

   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo `.env` con tus credenciales:**

   ```bash
   nano .env
   # o
   code .env
   ```

3. **Configura al menos estas variables:**
   ```env
   API_KEY=tu_api_key_de_bitfinex
   API_SECRET=tu_api_secret_de_bitfinex
   ```

## 🔑 Obtener Credenciales de API

1. Ve a [Bitfinex API Settings](https://setting.bitfinex.com/api)
2. Crea una nueva API Key
3. Configura los permisos necesarios:
   - **Orders**: Para ejemplos de trading
   - **Wallets**: Para ejemplos de wallet
   - **Withdraw**: Para ejemplos de retiro (opcional)
4. Guarda tu API Key y Secret de forma segura

## 📝 Variables Disponibles

### Credenciales (Obligatorias para ejemplos autenticados)

- `API_KEY`: Tu API Key de Bitfinex
- `API_SECRET`: Tu API Secret de Bitfinex

### URLs de Conexión (Opcional)

- `REST_URL`: URL del REST API (default: https://api.bitfinex.com)
- `WS_URL`: URL del WebSocket API (default: wss://api.bitfinex.com/ws/2)
- `TEST_URL`: URL para testing

### Configuración de Red (Opcional)

- `SOCKS_PROXY_URL`: URL del proxy SOCKS si necesitas uno

### Debug y Desarrollo

- `DEBUG`: Patrones de debug (ej: `bfx:*`, `bfx:examples:*`)
- `NODE_ENV`: Entorno de Node.js (development, production, test)

## 🚀 Ejemplos de Uso

### Ejemplos Públicos (No requieren credenciales)

```bash
# Listar símbolos disponibles
node examples/rest2/symbols.js

# Obtener tickers
node examples/rest2/tickers.js

# WebSocket tickers en tiempo real
node examples/ws2/tickers.js

# Order books en tiempo real
node examples/ws2/order_books.js
```

### Ejemplos Privados (Requieren API_KEY y API_SECRET)

```bash
# Ver wallets
node examples/rest2/wallets.js

# Ver posiciones
node examples/rest2/positions.js

# Crear orden (¡CUIDADO EN PRODUCCIÓN!)
node examples/rest2/submit_order.js
```

## 🛡️ Seguridad

### ⚠️ IMPORTANTE

- **Nunca subas tu archivo `.env` a Git**
- **Mantén tus credenciales privadas**
- **Usa permisos mínimos en tu API Key**
- **Para testing, usa cantidades pequeñas**

### Configuración de Permisos de API Key

Para diferentes ejemplos necesitarás diferentes permisos:

- **Solo lectura**: `Orders (Read)`, `Wallets (Read)`, `Margin (Read)`
- **Trading**: `Orders (Read/Write)`, `Wallets (Read)`
- **Completo**: Todos los permisos (solo si es necesario)

## 🔧 Debug y Troubleshooting

### Habilitar Debug

```env
# Ver todos los logs de Bitfinex
DEBUG=bfx:*

# Solo logs de ejemplos
DEBUG=bfx:examples:*

# Solo WebSocket
DEBUG=bfx:ws2

# Múltiples patrones
DEBUG=bfx:examples:*,bfx:ws2
```

### Problemas Comunes

1. **Error de autenticación**: Verifica API_KEY y API_SECRET
2. **Error de permisos**: Asegúrate de que tu API Key tenga los permisos necesarios
3. **Error de conexión**: Verifica tu conexión a internet o configuración de proxy
4. **Rate limiting**: Espera unos segundos entre requests

## 📚 Ejemplos de Configuración

### Configuración Básica

```env
API_KEY=tu_api_key
API_SECRET=tu_api_secret
DEBUG=bfx:examples:*
```

### Configuración con Proxy

```env
API_KEY=tu_api_key
API_SECRET=tu_api_secret
SOCKS_PROXY_URL=socks5://127.0.0.1:1080
DEBUG=bfx:*
```

### Configuración de Desarrollo

```env
API_KEY=tu_api_key
API_SECRET=tu_api_secret
NODE_ENV=development
DEBUG=bfx:examples:*,bfx:ws2
```

## 🧪 Testing

Para probar que tu configuración funciona:

```bash
# Test básico (no requiere credenciales)
node examples/rest2/symbols.js

# Test con credenciales
node examples/rest2/wallets.js

# Test WebSocket
timeout 10s node examples/ws2/tickers.js
```

Si ves datos, ¡tu configuración está funcionando! 🎉
