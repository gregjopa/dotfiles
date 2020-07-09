#!/usr/bin/env zsh

# install latest LTS version of Node
volta install node

# install global node modules
volta install \
  fkill-cli \
  npm-check-updates \
  speed-test \
  tldr \
  gatsby-cli
