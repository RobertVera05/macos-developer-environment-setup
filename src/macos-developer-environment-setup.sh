#!/bin/bash

# Exit on any error
set -e

echo " Starting MacOS developer environment..."

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
