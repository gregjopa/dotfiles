export ZSH="$HOME/.oh-my-zsh"

plugins=(
  common-aliases
  docker-compose
  git
  gnu-utils
  magic-enter
)

source $ZSH/oh-my-zsh.sh

if [ -f "$HOME"/.aliases ]; then
  . "$HOME"/.aliases
fi

if [ -f "$HOME"/.functions ]; then
  . "$HOME"/.functions
fi

# Add color to macOS terminal
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$HOME/.exenv/bin:$PATH"
eval "$(exenv init -)"

# Remove duplicates from PATH
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# starship theme - https://starship.rs/
eval "$(starship init zsh)"
