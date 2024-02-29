# Activate ble.sh
source ~/.local/Linux/share/blesh/ble.sh

# Activate starship
eval "$(starship init bash)"

# Activate atuin.sh
eval "$(atuin init bash)"

# Aliases
alias vi="nvim"
alias vim="nvim"
alias lg="lazygit"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

