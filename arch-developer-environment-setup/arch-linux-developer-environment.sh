#!/bin/bash

# Exit on any error
set -e

echo "🏁 Starting Arch Linux developer environment setup.."

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Please do not run this script as root. Use your regular user account."
    exit 1
fi

########################################
# System Update
########################################
echo "🔄 Updating system packages..."
sudo pacman -Syu --noconfirm

########################################
# Base Development Tools
########################################
echo "📦 Installing base development tools..."
sudo pacman -S --noconfirm base-devel git wget curl vim htop tmux make cmake gcc
sudo pacman -S --noconfirm linux-headers

########################################
# AUR Helper (yay)
########################################
echo "🦄 Installing yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
else
    echo "✅ yay is already installed"
fi

########################################
# Oh My Zsh
########################################
echo "💡 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh is already installed"
fi

########################################
# Zsh Plugins
########################################
echo "🔌 Installing zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/gitfast" ]; then
    git clone https://github.com/olivierverdier/zsh-git-prompt.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-git-prompt
fi

########################################
# Programming Languages - Core
########################################
echo "⌨️ Installing Programming Languages..."
sudo pacman -S --noconfirm python python-pip python-virtualenv python-nodejs
sudo pacman -S --noconfirm go rust go-tools cargo
sudo pacman -S --noconfirm jdk-openjdk openjdk-source
sudo pacman -S --noconfirm ruby ruby-bundler
sudo pacman -S --noconfirm php php-fpm php-mysql php-pgsql php-gd php-curl
sudo pacman -S --noconfirm lua luarock
sudo pacman -S --noconfirm lua53 lua53-lpeg
sudo pacman -S --noconfirm erlang elixir
sudo pacman -S --noconfirm elixir-ls
sudo pacman -S --noconfirm dart
sudo pacman -S --noconfirm kotlin
sudo pacman -S --noconfirm clojure
sudo pacman -S --noconfirm leiningen

########################################
# Node.js and JavaScript Ecosystem
########################################
echo "📦 Setting up Node.js tools..."
sudo pacman -S --noconfirm nodejs npm yarn
sudo pacman -S --noconfirm typescript-tslint

# Install nvm for Node.js version management
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
fi

########################################
# Rust Development Tools
########################################
echo "🦀 Setting up Rust tools..."
export RUSTUP_HOME=$HOME/.rustup
export CARGO_HOME=$HOME/.cargo
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
cargo install cargo-edit cargo-watch cargo-audit
rustup component add rustfmt clippy rust-analysis

########################################
# Databases
########################################
echo "🗄️ Installing Databases..."
sudo pacman -S --noconfirm postgresql postgresql-libs psqlodbc
sudo pacman -S --noconfirm mongodb mongodb-tools
sudo pacman -S --noconfirm redis
sudo pacman -S --noconfirm mysql mysql-clients
sudo pacman -S --noconfirm sqlite
sudo pacman -S --noconfirm neo4j
sudo pacman -S --noconfirm couchdb
sudo pacman -S --noconfirm rabbitmq-server
sudo systemctl enable postgresql
sudo systemctl enable mongodb
sudo systemctl enable redis
sudo systemctl enable mysql

########################################
# Containerization and Virtualization
########################################
echo "📦 Installing containerization tools..."
sudo pacman -S --noconfirm docker podman buildah skopeo
sudo systemctl enable docker
sudo usermod -aG docker $USER

########################################
# Version Control
########################################
echo "🔄 Installing version control tools..."
sudo pacman -S --noconfirm git-gui git-flow git-delta

########################################
# Development Utilities
########################################
echo "🔨 Installing development utilities..."
sudo pacman -S --noconfirm code-server gh
sudo pacman -S --noconfirm diff-so-fancy
sudo pacman -S --noconfirm fd ripgrep fzf
sudo pacman -S --noconfirm bat exa lsd
sudo pacman -S --noconfirm jq yq
sudo pacman -S --noconfirm tree
sudo pacman -S --noconfirm zoxide
sudo pacman -S --noconfirm zsh-powerlevel10k
sudo pacman -S --noconfirm fonts-fira-code ttf-jetbrains-mono ttf-inter

########################################
# Network Tools
########################################
echo "🌐 Installing network tools..."
sudo pacman -S --noconfirm nmap tcpdump mtr wireshark-chrome
sudo pacman -S --noconfirm postman-bin
sudo pacman -S --noconfirm httpie

########################################
# IDEs and Text Editors (AUR)
########################################
echo "💻 Installing IDEs and editors..."
yay -S --noconfirm clion-jetbrains
yay -S --noconfirm datagrip-jetbrains
yay -S --noconfirm pycharm-professional-jetbrains
yay -S --noconfirm intellij-idea-ultra-edition-jetbrains
yay -S --noconfirm webstorm-jetbrains
yay -S --noconfirm rider-jetbrains
yay -S --noconfirm rustrover-jetbrains
yay -S --noconfirm android-studio
yay -S --noconfirm flutter-snap
yay -S --noconfirm zed-editor

########################################
# GUI Applications
########################################
echo "💻 Installing GUI applications..."
yay -S --noconfirm ghostty
yay -S --noconfirm helium-browser
yay -S --noconfirm 1password
yay -S --noconfirm discord
yay -S --noconfirm transmission-qt
yay -S --noconfirm vlc
yay -S --noconfirm obs-studio
yay -S --noconfirm inkscape
yay -S --noconfirm gimp
yay -S --noconfirm blender

########################################
# Cleanup
########################################
echo "🧹 Cleaning up..."
sudo pacman -Rns --noconfirm $(pacman -Qtdq 2>/dev/null || true)
sudo pacman -Scc --noconfirm
rm -rf /tmp/yay

########################################
# Post-Installation Setup
########################################
echo "🔧 Setting up shell configuration..."

# Update Zsh configuration if it exists
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "ZSH_THEME=\"agnoster\"" "$HOME/.zshrc" 2>/dev/null; then
        sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' "$HOME/.zshrc"
    fi

    if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" "$HOME/.zshrc" 2>/dev/null; then
        sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$HOME/.zshrc"
    fi
fi

########################################
# Change Default Shell to Zsh
########################################
echo "🐚 Changing default shell to zsh..."
if grep -q "zsh" /etc/shells; then
    chsh -s $(which zsh)
    echo "✅ Default shell changed to zsh"
else
    echo "⚠️  zsh not found in /etc/shells. Please install zsh first."
fi

echo ""
echo "🎉 Arch Linux developer environment setup is complete!"
echo ""
echo "📋 Please run the following commands to apply changes:"
echo "   - source ~/.zshrc"
echo "   - Or restart your terminal"
echo ""
echo "📋 Manual steps you may need to complete:"
echo "   1. Start services: sudo systemctl start postgresql docker redis"
echo "   2. Set up your database: psql -U postgres"
echo "   3. Configure IDE licenses if needed"
echo "   4. Install any additional fonts you prefer"
echo ""
echo "💡 To update your system in the future, use: sudo pacman -Syu"
echo ""
