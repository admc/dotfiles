export PATH=/usr/local/git/bin:$PATH
export PATH=/Users/adam:$PATH
export PATH=/Users/adam/Documents/projects/flex_sdk/bin:$PATH

alias ll='ls -al' 
alias ..='cd ..'

#iTerm stuff
# Put the penultimate and current directory in the iterm tab:
export CLICOLOR=1
export LSCOLORS=CxFxExDxBxegedabagacad
export TERM=xterm-color

function settab { 
        echo -ne "\e]1;$( echo -ne $PWD:h:t/$PWD:t|sed 's|.*\(.\{20\}\)$|\1|')\a"    
        } 

# Put the string " [zsh]   hostname::/full/directory/path" in the title bar:
    
function settitle { echo -ne "\e]2;[zsh]   $HOST:r:r::$PWD\a" }

# This updates after each change of directory:

function chpwd { settab;settitle }

# These put the name of the program running in the tab, and then remove it
# when the program has finished:

function preexec { printf "\e]1; $(history $HISTCMD | cut -b7- ) \a" } 
function precmd { settab }

autoload -Uz colors && colors
local text="%{$fg_no_bold[cyan]%}"
local text_emph="%{$fg_bold[green]%}"
local punctuation="%{$fg_bold[green]%}"
local emph="%{$fg_no_bold[white]%}"
local final="%{$reset_color%}"
 
# PROMPT="${punctuation}(${text_emph}%n${emph}@${text}%m${punctuation})(${emph}%j${text} job[s]${punctuation})(${text}%D{%A, %B %d, %Y : %H:%M:%S}${punctuation})-
# (${emph}%#${punctuation}:%!${text}:%1~${punctuation})-${final} "
PROMPT="${punctuation}(${text_emph}%n${emph}@${text}%m${punctuation})(${emph}%#${punctuation}:%!${text}:%1~${punctuation}):${final} "

PROMPT2="${text}%_${punctuation}|-${final} "

# Setup Amazon EC2 Command-line Tools:
export EC2_HOME="$HOME/Projects/ec2"
export PATH="$PATH:$EC2_HOME/bin"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"

# Setup for using Sauce build out scripts:
#export EC2_PRIVATE_KEY=$EC2_HOME/pk-
#export EC2_CERT=$EC2_HOME/cert-
#export AWS_ACCOUNT_ID=""
#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""
#export EC2_KEYPAIR="$EC2_HOME/ec2-$USER-dev.key"
#export PYTHONPATH="$HOME/Projects/sauce/lib"

# ~/.zshrc
# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen" ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'

  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'

  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\

    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
  # called by zsh before executing a command
  function preexec()
  {
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus
  }
  # called by zsh before showing the prompt
  function precmd()
  {
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus
  }
fi
