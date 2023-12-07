switch (uname)
case Linux
    if status --is-login
        fish_add_path $HOME/.cargo/bin
        fish_add_path $HOME/.local/Linux/bin
    end
    if status --is-interactive
        if test -e $HOME/.local/Linux/bin/starship
            $HOME/.local/Linux/bin/starship init fish | source
        end
    end
end
