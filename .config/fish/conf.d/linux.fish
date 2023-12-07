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
            #if test -e $HOME/.local/Linux/bin/atuin
            #   $HOME/.local/Linux/bin/atuin init fish | source
            #end
            if test -e $HOME/.ghcup/bin
                fish_add_path $HOME/.ghcup/bin
            end
            if echo (hostname | cut -d. -f2) -eq 'anvil'
                fish_add_path /anvil/projects/tdm/bin/
                set -gx SINGULARITY_CACHEDIR $SCRATCH/.singularity/cache
            end
        end
    case '*'
end
