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
  git-flow-completion
  zsh-syntax-highlighting
  osx
  alias-tips
  extract
  npm
  node
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

# MacOS disable hold for special characters
alias disableHold='defaults write -g ApplePressAndHoldEnabled -bool false'
alias enableHold='defaults write -g ApplePressAndHoldEnabled -bool true'

# MacOS show hidden files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Function to transfer files
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }; alias transfer=transfer

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

  echo "alias $NAME='$DEFINTION'" >> ~/.zshrc
  . ~/.zshrc
}

