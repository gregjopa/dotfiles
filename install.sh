#!/usr/bin/env bash

if xcode-select -p &> /dev/null; then
  echo "Xcode Command Line Utilities are already installed"
else
  echo "Installing Xcode Command Line Utilities"
  xcode-select --install
fi

if command -v brew &> /dev/null; then
  echo "Homebrew is already installed"
else
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Make sure we're using the latest homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Remove outdated versions from the cellar
brew cleanup

# Save homebrew’s install location
BREW_PREFIX=$(brew --prefix)

brew install zsh

# Switch to using brew-installed zsh as default shell
if ! grep -F -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "Configuring shell to use brew-installed zsh"
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/zsh";
fi;

if [ -d $HOME/.oh-my-zsh ]; then
  echo "Oh-My-Zsh is already installed"
else
  echo "Installing Oh-My-Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if command -v volta &> /dev/null; then
  echo "Volta is already installed"
else
  echo "Installing Volta"
  /bin/bash -c "$(curl -fsSL https://get.volta.sh)"
fi

# Install starship theme
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install starship

# Install elixir
brew install exenv
brew install elixir-build
brew install erlang

brew install bat
brew install exa
