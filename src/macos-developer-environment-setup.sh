#!/bin/bash

# Exit on any error
set -e

echo "🏁 Starting MacOS developer environment setup..."

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

########################################
# Xcode Command Line Tools
########################################
echo "📦 Installing Xcode Command Line Tools..."
xcode-select --install || echo "✅ Xcode Command Line Tools already installed"

########################################
# Homebrew
########################################
echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "🔄 Updating and upgrading Homebrew..."
brew update && brew upgrade

########################################
# Oh My Zsh
########################################
echo "💡 Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

########################################
# Programming Languages
########################################
echo "⌨️ Installing Programming Languages"
brew install openjdk
brew install gcc
brew install rust
brew install python
brew install go
brew install node
brew install mongodb-community
brew install mongosh
brew install postgresql

########################################
# Utilities
########################################
echo "🔨 Installing Extra Tools"
brew install curl
brew install git
brew install nvm
brew install vim
brew install zsh
brew install wget
brew install rust

########################################
# Casks
########################################
echo "💻 Installing GUI Applications"
brew install --casks ghostty
brew install --casks helium-browser
brew install --casks 1kc-razer
brew install --casks 1password
brew install --casks clion
brew install --casks datagrip
brew install --casks discord
brew install --casks docker
brew install --casks intellij-idea
brew install --casks libreoffice
brew install --casks plex
brew install --casks plexamp
brew install --casks postman
brew install --casks private-internet-access
brew install --casks pycharm
brew install --casks rider
brew install --casks rustrover
brew install --casks transmission
brew install --casks vlc
brew install --casks webstorm
brew install --casks whatsapp
brew install --casks wireshark-app
brew install --casks zed
brew install --casks flutter
brew install --casks android-studio
brew install --casks thunderbird

########################################
# Cleanup
########################################
echo "🧹 Cleaning up..."
brew cleanup

echo "Developer environment setup is complete! Please restart your terminal."
