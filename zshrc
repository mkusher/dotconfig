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
alias cdt='cd ~/Projects/tdh'
alias gpcb='gp --set-upstream origin $(current_branch)'
alias gpf='gp --force-with-lease'
alias dpwd='docker run --rm -it -v $(pwd):$(pwd) -w $(pwd)'
#alias codex='OPENAI_API_KEY=$(op read op://private/OpenAI/api_key --no-newline) ~/.asdf/shims/codex'
alias ai-agent-container='docker run --rm -it -v $(pwd):$(pwd) -v $HOME/.claude:$HOME/.claude -v $HOME/.config:$HOME/.config -v $HOME/.local:$HOME/.local -v $HOME/.agent:$HOME/.agent -w $(pwd) ai-agent'
alias claude='ai-agent-container claude'
alias opencode='ai-agent-container opencode'

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

peek() { tmux split-window -p 33 $EDITOR $@ || exit; }

export PATH="$HOME/.local/bin:/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Added by Antigravity
export PATH="/Users/akashnikau/.antigravity/antigravity/bin:$PATH"
