# Bring in lmod if /etc/profile.d/modules.sh exists
if [[ -f /etc/profile.d/modules.sh ]]; then
    source /etc/profile.d/modules.sh
fi

# Bring in stowed binaries to $PATH
if [[ "$(uname)" == "Linux" ]]; then
   export PATH=$PATH:$HOME/.local/Linux/bin
fi

# Add cargo installed binaries to $PATH
export PATH=$PATH:$HOME/.cargo/bin

# If on Anvil set the APPTAINER_CACHEDIR to be in $SCRATCH
if [[ $(hostname | cut -f2 -d.) == 'anvil' ]]; then
    export APPTAINER_CACHEDIR="$SCRATCH/.apptainer/cache"
    export SINGULARITY_CACHEDIR="$SCRATCH/.singularity/cache"
fi

# KEEP AT END SO PATH IS UPDATED FIRST. Read in $HOME/.bashrc as well
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
