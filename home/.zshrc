# Nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]
then
    . ~/.nix-profile/etc/profile.d/nix.sh
fi
export TERMINFO=~/.nix-profile/share/terminfo

export PATH=$HOME/.bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# SSL certificate file
export SSL_CERT_FILE="$NIX_SSL_CERT_FILE"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git stack)

source $ZSH/oh-my-zsh.sh

# Emacsclient that automatically loads emacs in daemon mode
alias ec='emacsclient --alternate-editor='''

# Java home location
if [ "$(hostname)" = 'C02MC13TFD58' ]; then
    JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home'
    export JAVA_HOME
fi

# SBT using global repository settings
GCMD_OPTS='-J-Xmx4g -J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC -J-Xss2M'
GSBT_OPTS=''
GJAVA_OPTS=''
alias gsbt="JAVA_OPTS='${GJAVA_OPTS}' SBT_OPTS='${GSBT_OPTS}' sbt ${GCMD_OPTS}"

# SBT using tooling.repositories settings
LCMD_OPTS="${GCMD_OPTS}"
LSBT_OPTS="${GSBT_OPTS} -Dsbt.override.build.repos=true -Dsbt.repository.config=${HOME}/workspace/tooling.repositories/repositories"
LJAVA_OPTS="${GJAVA_OPTS}"
alias lsbt="JAVA_OPTS='${GJAVA_OPTS}' SBT_OPTS='${LSBT_OPTS}' sbt ${LCMD_OPTS}"

# Brings "work secrets" into scope as environment variables
alias work-secrets='ansible-vault view ${HOME}/.secrets/work.sh.encrypted | source /dev/stdin'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### PROXY SETTINGS ####

# Start cntlm
function cntlmon {
    cntlm_config=~/.etc/cntlm.conf
    cntlm -c "${cntlm_config}"
}

# Enables proxy
function proxyon {
    export HTTP_PROXY=http://127.0.0.1:3128
    export http_proxy=$HTTP_PROXY
    export HTTPS_PROXY=$HTTP_PROXY
    export https_proxy=$HTTP_PROXY
}

# Disables proxy
function proxyoff {
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
}

# Turns on wifi
function wifion {
    proxyoff
    networksetup -setairportpower en0 on
}

# Turns off wifi
function wifioff {
    proxyon
    networksetup -setairportpower en0 off
}
