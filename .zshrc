###########################
#########ZSH CONFIG########
###########################
# Compfix
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=/Users/$USER/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# emulate bash PROMPT_COMMAND (only for zsh)
precmd() { eval "$PROMPT_COMMAND" }

###########################
###Add variables to path###
###########################

# Add composer stuff to path
export PATH=$PATH:$HOME/.composer/vendor/bin

# Add python to path
if [ -d "$HOME/Library/Python/3.7/bin/" ] ; then
    PATH="$HOME/Library/Python/3.7/bin/:$PATH"
fi

# Add php to path
export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  

# Add android emulator to path
export PATH="/Users/$USER/Library/Android/sdk/emulator:$PATH"

export ANDROID_HOME="/Users/$USER/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

export PATH="$PATH:/Users/$USER/flutter/bin"

export PATH="/usr/local/sbin:$PATH"

############################
#Custom added functionality#
############################

# Change default language 
export LANG=en_EN.UTF-8

# Import aliases from separate file
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

# open new terminal in same dir
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" 

# script to initialize ssh-agent and add all identities to it 
{ 
  eval `ssh-agent -s` 
  find ~/.ssh/ -type f -exec grep -l "PRIVATE" {} \; | xargs ssh-add &> /dev/null 
} &> /dev/null 

# Function to create new alias
new-alias () { 
  if [ -z "$1" ]; then
    echo "alias name:"
    read NAME
  else
    NAME=$1
  fi
  if [ -z "$2" ]; then
    echo "alias definition:"
    read DEFINTION
  else
    if [ "$2" = "-cd" ]; then
      DEFINTION='cd '
    else
      DEFINTION=$2
    fi
  fi

  echo "alias $NAME='$DEFINTION'" >> ~/.zsh_aliases
  . ~/.zsh_aliases
}

source /Users/$USER/.zsh_signature


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
