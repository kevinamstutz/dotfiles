switch (uname)
case Darwin
    if status --is-login
        fish_add_path /opt/homebrew/bin
        fish_add_path $HOME/.local/bin/darwin
    end
    if status --is-interactive
        if test -e $HOME/.local/bin/darwin/starship
            starship init fish | source
        end
        if test -e /opt/homebrew/bin/brew
            eval (/opt/homebrew/bin/brew shellenv)

            for directory in /opt/homebrew/*/libexec/gnubin
                fish_add_path $directory
            end
        end
    end
end
