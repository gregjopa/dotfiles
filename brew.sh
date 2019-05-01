#!/usr/bin/env bash

if ! command -v brew > /dev/null 2>&1; then
  echo "Installing Homebrew ..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Dev tools
brew install bash
brew install bash-completion2
brew install git

# Remove outdated versions from the cellar
brew cleanup
