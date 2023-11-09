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

# Node
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Remove duplicates from PATH
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# starship theme - https://starship.rs/
eval "$(starship init zsh)"

# smarter cd command - https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
