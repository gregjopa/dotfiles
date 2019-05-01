#!/usr/bin/env bash

if [ -f "$HOME"/.aliases ]; then
  . "$HOME"/.aliases
fi

if [ -f "$HOME"/.bash_functions ]; then
  . "$HOME"/.bash_functions
fi

if [ -f "$HOME"/.bash_prompt ]; then
  . "$HOME"/.bash_prompt
fi

if [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
  . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g;
fi;

# Add color to macOS terminal
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"
