# See: https://github.com/ohmyzsh/ohmyzsh/issues/6835
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=/Users/kamstut/.oh-my-zsh

# Set zsh theme
ZSH_THEME="honukai"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh_reload
  tmux
  sudo # escape key twice
  ssh-agent
  rustup
  rust
  rsync
  ripgrep
  pyenv
  httpie
  docker
  cargo
  zsh-autosuggestions
)

zstyle :omz:plugins:ssh-agent agent-forwarding on
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# User configuration

export EDITOR='nvim'
export TERM='xterm-256color'

# add cargo binaries to path
export PATH="$PATH:$HOME/.cargo/bin"

alias users="awk -F ':' '{print $1}' /etc/passwd"
alias allgroups="awk -F ':' '{print $1}' /etc/group"
alias dropbox="python2.7 ~/.dropbox.py"
alias vim="nvim"

eval "$(pyenv init -)"

alias ls="exa --all --long --header --git --group --modified --created"
alias ll="exa --all --long --header --git --group --modified --created"
alias la="exa --all --long --header --git --group --modified --created"

# Replace posix tools with gnu equivalents for consistency with linux
if type brew &>/dev/null; then
	HOMEBREW_PREFIX=$(brew --prefix)
	for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
fi

# See: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=/Users/kamstut/.cfg/ --work-tree=/Users/kamstut'

# Use ripgrep in fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git/"'
export FZF_DEFAULT_OPTS='--height 96% --reverse --preview "cat {}"'
