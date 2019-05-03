#!/usr/bin/env bash

if ! command -v brew > /dev/null 2>&1; then
  echo "Installing Homebrew ..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we're using the latest homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Save homebrew’s install location
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities
brew install coreutils

# Install latest bash
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Dev tools
brew install git

# Remove outdated versions from the cellar
brew cleanup
