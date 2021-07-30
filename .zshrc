# Setup history
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Use bourne-shell-compatible word splitting.
setopt SH_WORD_SPLIT
# Allow comments in interactive shell
setopt INTERACTIVE_COMMENTS

# Make the shell's builtin pwd default to -P
set -o physical

# VI mode
bindkey -v

export EDITOR=nvim
export VISUAL=nvim

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias e=nvim
disable -r time # disable shell reserved word
alias time='time --verbose '

alias gco="git checkout"
alias gci="git commit"
alias gamend="git commit -a --amend --no-edit"
alias gst="git status"
alias gba="git branch"
alias gdi="git diff"

# set XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# Load git prompt functions
source $HOME/.config/shell/git-prompt.sh
# Setup prompt
setopt PROMPT_SUBST
autoload -U colors && colors
PS1='%{$fg[green]%}%n@%2m: %{$fg[blue]%}%~%{$fg[green]%}$(__git_ps1)%{$reset_color%}
> '

# Add .bin to PATH
export PATH="$PATH:$HOME/.bin"
# Setup fzf
export PATH="$PATH:$HOME/.extra/fzf/bin"
# Auto-completion
[[ $- == *i* ]] && source "$HOME/.config/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "$HOME/.extra/fzf/shell/key-bindings.zsh"

# Local overrides
source $HOME/.zshrc.local
