# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_UPDATE="true"
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias t='tmux'
alias tl='tmux list-sessions'
alias ta='tmux attach -t'
alias vim=nvim
alias vi=nvim
alias pr='hub pull-request'
alias cdt='cd ~/Projects/workarea/tdh'
alias gpcb='gp --set-upstream origin $(current_branch)'
alias gpf='gp --force-with-lease'

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
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

peek() { tmux split-window -p 33 $EDITOR $@ || exit; }

export PATH="$HOME/.local/bin:/usr/local/sbin:$PATH"

autoload -U +X compinit && compinit
