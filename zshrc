# Path to your oh-my-zsh installation.
export ZSH=/Users/mkusher/.oh-my-zsh

DISABLE_AUTO_UPDATE="true"
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
ZSH_THEME="agnoster"

plugins=(git)
source $ZSH/oh-my-zsh.sh

alias chrome='open -a Google\ Chrome'
alias t='tmux'
alias tl='tmux list-sessions'
alias ta='tmux attach -t'
alias vim=nvim
alias vi=nvim
alias pr='hub pull-request'
alias cdo='cd ~/Projects/workarea/overlai'
alias gpcb='gp --set-upstream origin $(current_branch)'
alias gpf='gp --force-with-lease'
alias docker-dev='docker-compose -p ehrworks -f docker-development.yml'
alias docker-test='docker-compose -p ehrworks -f docker-test.yml'
alias xdebug-enable='echo "[xdebug]\nzend_extension=\"/usr/local/opt/php72-xdebug/xdebug.so\"" > /usr/local/etc/php/7.2/conf.d/ext-xdebug.ini'
alias xdebug-disable='echo "[xdebug]\n" > /usr/local/etc/php/7.2/conf.d/ext-xdebug.ini'


## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

SEGMENT_SEPARATOR=$'\ue0b0'
INPUT_SIGN='$'
PROMPT='%{%f%b%k%}$(build_prompt) '
PROMPT="$PROMPT
$INPUT_SIGN "

export PATH="$HOME/.yarn/bin:$PATH"
