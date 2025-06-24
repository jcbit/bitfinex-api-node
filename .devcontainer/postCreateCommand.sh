#!/bin/bash

# Bitfinex API Node Development Container Post-Create Setup Script
# This script runs after the dev container is created

set -e  # Exit on any error

echo "🚀 Starting Bitfinex API Node development container setup..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update

# Install curl if not present
echo "🌐 Installing curl..."
sudo apt-get install -y curl

# Install SQL Server tools
echo "🛠️ Installing SQL Server tools..."

# Add Microsoft GPG key with retry mechanism
echo "🔐 Adding Microsoft repository keys..."

# Create keyrings directory if it doesn't exist
sudo mkdir -p /usr/share/keyrings

MAX_RETRIES=3
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg; then
        echo "✅ Microsoft GPG key added successfully"
        break
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "⚠️  Attempt $RETRY_COUNT failed to add Microsoft GPG key"
        if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
            echo "❌ Failed to add Microsoft GPG key after $MAX_RETRIES attempts"
            exit 1
        fi
        echo "🔄 Retrying in 2 seconds..."
        sleep 2
    fi
done

# Add Microsoft package repository
echo "📋 Adding Microsoft package repository..."
if curl -sSL https://packages.microsoft.com/config/debian/12/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list; then
    echo "✅ Microsoft repository added successfully"
else
    echo "❌ Failed to add Microsoft repository"
    exit 1
fi

# Update package lists with new repository
echo "🔄 Updating package lists with Microsoft repository..."
if sudo apt-get update; then
    echo "✅ Package lists updated successfully"
else
    echo "❌ Failed to update package lists"
    exit 1
fi

# Install SQL Server tools
echo "🔧 Installing SQL Server command line tools..."
if sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev; then
    echo "✅ SQL Server tools installed successfully"
    # Add SQL Server tools to PATH
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    echo "✅ SQL Server tools added to PATH"
else
    echo "❌ Failed to install SQL Server tools"
    exit 1
fi

# Verify SQL Server tools installation
echo "🔍 Verifying SQL Server tools installation..."

# Add SQL Server tools to current session PATH
export PATH="$PATH:/opt/mssql-tools/bin"

if command -v sqlcmd >/dev/null 2>&1; then
    echo "✅ sqlcmd is available: $(which sqlcmd)"
    # Test sqlcmd version
    if sqlcmd -? >/dev/null 2>&1; then
        echo "✅ sqlcmd is working correctly"
        SQLCMD_VERSION=$(sqlcmd -? 2>&1 | head -1)
        echo "📋 Version: $SQLCMD_VERSION"
    else
        echo "⚠️  sqlcmd found but not working properly"
    fi
elif [ -f "/opt/mssql-tools/bin/sqlcmd" ]; then
    echo "✅ sqlcmd found at /opt/mssql-tools/bin/sqlcmd"
    # Test with full path
    if /opt/mssql-tools/bin/sqlcmd -? >/dev/null 2>&1; then
        echo "✅ sqlcmd is working correctly"
        SQLCMD_VERSION=$(/opt/mssql-tools/bin/sqlcmd -? 2>&1 | head -1)
        echo "📋 Version: $SQLCMD_VERSION"
    else
        echo "❌ sqlcmd found but not working"
    fi
else
    echo "❌ sqlcmd not found after installation"
fi

# Install additional development tools
echo "🔧 Installing additional development tools..."
if sudo apt-get install -y git vim nano htop tree jq; then
    echo "✅ Additional development tools installed successfully"
else
    echo "❌ Failed to install additional development tools"
    exit 1
fi

# Install global npm packages
echo "📦 Installing global npm packages..."
if sudo npm install -g nodemon typescript ts-node @types/node; then
    echo "✅ Global npm packages installed successfully"
else
    echo "❌ Failed to install global npm packages"
    exit 1
fi

# Set up workspace permissions
echo "🔐 Setting up workspace permissions..."
current_user=$(whoami)
current_group=$(id -gn)

echo "📋 Current user: $current_user, group: $current_group"

# Check if workspace directory exists and set permissions
if [ -d "/workspace" ]; then
    echo "📁 Workspace directory found, setting permissions..."
    
    # Change ownership of workspace to current user
    if sudo chown -R $current_user:$current_group /workspace; then
        echo "✅ Workspace ownership changed to $current_user:$current_group"
    else
        echo "❌ Failed to change workspace ownership"
        exit 1
    fi
    
    # Ensure package.json is writable
    if [ -f "/workspace/package.json" ]; then
        sudo chown $current_user:$current_group /workspace/package.json
        sudo chmod u+rw /workspace/package.json
    fi
    
    # Ensure package-lock.json is writable if it exists
    if [ -f "/workspace/package-lock.json" ]; then
        sudo chown $current_user:$current_group /workspace/package-lock.json
        sudo chmod u+rw /workspace/package-lock.json
    fi
    
    echo "✅ Workspace permissions corrected"
fi

# Verify we can write to workspace
echo "🔍 Verifying write permissions..."
if touch /workspace/.permission-test 2>/dev/null; then
    rm -f /workspace/.permission-test
    echo "✅ Workspace write permissions confirmed"
else
    echo "❌ Still cannot write to workspace directory"
    ls -la /workspace/ | head -5
    exit 1
fi

# Upgrade npm to latest version
echo "📦 Upgrading npm to latest version..."
if npm install -g npm@latest; then
    echo "✅ npm upgraded successfully"
    echo "📋 npm version: $(npm --version)"
else
    echo "❌ Failed to upgrade npm"
    exit 1
fi

# Change to workspace directory
cd /workspace

# Verificar que el archivo .env existe o crearlo
if [ ! -f .env ]; then
    echo "📝 Creando archivo .env de ejemplo..."
    cat > .env << EOF
# Bitfinex API Configuration
NODE_ENV=development
API_KEY=your_api_key_here
API_SECRET=your_api_secret_here
EOF
    echo "✅ Archivo .env creado"
fi

# Install npm dependencies
echo "🔄 Installing npm dependencies in $(pwd)..."
if npm install; then
    echo "✅ Node.js dependencies installed successfully"
else
    echo "❌ Failed to install Node.js dependencies"
    echo "📋 Workspace permissions:"
    ls -la /workspace/ | head -5
    echo "📋 Current user info:"
    whoami
    id
    exit 1
fi

echo "✅ Bitfinex API Node development container setup completed successfully!"
echo "🎉 Ready to start developing!"
echo ""
echo "💡 Comandos útiles:"
echo "   npm test          - Ejecutar tests"
echo "   npm run lint      - Verificar código"
echo "   npm run docs      - Generar documentación"
echo ""
echo "🔗 Puerto 3060 disponible para el servidor de desarrollo"
echo "🔗 Puerto 3061 disponible para testing"
echo "🔗 Puerto 3062 disponible para otros servicios"
