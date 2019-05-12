#!/usr/bin/env bash

# Save homebrew’s install location
BREW_PREFIX=$(brew --prefix)

# Use normal command names with coreutils
if [ -d "$BREW_PREFIX"/opt/coreutils/libexec/gnubin/ ]; then
  export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi

# Add tab completion for many bash commands
if [ -f "$BREW_PREFIX"/etc/profile.d/bash_completion.sh ]; then
  . "$BREW_PREFIX"/etc/profile.d/bash_completion.sh
fi

# Add tab completion for git commands
if [ -f "$BREW_PREFIX"/etc/bash_completion.d/git-completion.bash ]; then
  . "$BREW_PREFIX"/etc/bash_completion.d/git-completion.bash
fi

if [ -f "$HOME"/.aliases ]; then
  . "$HOME"/.aliases
fi

if [ -f "$HOME"/.bash_functions ]; then
  . "$HOME"/.bash_functions
fi

if [ -f "$HOME"/.bash_prompt ]; then
  . "$HOME"/.bash_prompt
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g;
fi;

# Add color to macOS terminal
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$HOME/.exenv/bin:$PATH"
eval "$(exenv init -)"

# Remove duplicates from PATH
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
