# Changelog - v7.2.0

## 🚀 **Version 7.2.0** - July 2025

### ✨ **New Features**

- **Fixed WebSocket Filter Logic**: Corrected `_payloadPassesFilter` to properly handle empty filter values (`null`, `undefined`, empty strings)
- **Enhanced Dependency Management**: Updated all packages to latest stable versions
- **Improved Copilot Instructions**: Added comprehensive AI coding agent guidelines

### 🔧 **Improvements**

- **Dependencies Updated**: 
  - `bignumber.js`: 9.3.0 → 9.3.1
  - `ws`: 8.18.2 → 8.18.3
  - `dotenv`: 16.4.5 → 17.2.1 (major version upgrade)
  - `jsdoc-to-markdown`: 9.0.1 → 9.1.2
  - `mocha`: 11.7.0 → 11.7.1
- **Code Quality**: Removed unused imports and cleaned up linting issues
- **Test Reliability**: Fixed critical test failure in WebSocket message filtering

### 🐛 **Bug Fixes**

- **WebSocket Filtering**: Fixed `_payloadPassesFilter` function to use `lodash/isEmpty` instead of `_isUndefined` for proper empty value handling
- **Test Suite**: All 228 unit tests now passing (3 specific sequencing tests remain intentionally skipped)

### 📚 **Documentation**

- **AI Agent Support**: Added comprehensive `.github/copilot-instructions.md` with:
  - Architecture overview and key components
  - Development workflow and testing patterns
  - Critical dependencies and performance considerations
  - Common debugging scenarios

### 🎯 **Technical Details**

#### WebSocket Filter Fix
The `_payloadPassesFilter` function now correctly handles all empty values:
```javascript
// Before: Only checked _isUndefined(filterValue)
// After: Uses _isEmpty(filterValue) for comprehensive empty checking
if (_isEmpty(filterValue) || filterValue === '*') {
  continue // Skip filtering for empty values
}
```

This fix ensures that WebSocket subscription filters work correctly with:
- `undefined` values
- `null` values  
- Empty strings `''`
- Empty arrays `[]`
- Empty objects `{}`

#### Dependency Highlights
- **dotenv v17**: Enhanced environment variable management with better logging
- **ws v8.18.3**: Latest WebSocket implementation with security fixes
- **mocha v11.7.1**: Updated testing framework with improved performance

### ⚠️ **Breaking Changes**

None. This release maintains 100% backward compatibility.

### 🔄 **Migration Guide**

No migration required. Simply update your package.json:

```bash
npm install @jcbit/bitfinex-api-node@^7.2.0
```

### 🧪 **Validation**

- ✅ **228 unit tests** passing
- ✅ **All integration tests** passing
- ✅ **Zero linting errors**
- ✅ **Example scripts** verified working
- ✅ **Dependencies** security audited

---

**📊 Test Results Summary:**
- 228 passing ✅
- 3 pending (sequencing edge cases, intentionally skipped)
- 0 failing ❌
- 100% core functionality working

**🔗 Useful Links:**
- [Full Technical Review](TECHNICAL-REVIEW.md)
- [Development Setup](ENV-SETUP.md)
- [AI Agent Instructions](.github/copilot-instructions.md)
