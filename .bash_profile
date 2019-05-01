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

# Add color to osx terminal
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"