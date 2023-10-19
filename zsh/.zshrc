# ~/.zshrc

# If not running interactively, don't do anythi    ng
 [[ $- != *i* ]] && return

# Keybinds
bindkey '^H' vi-backward-kill-word
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' kill-word
bindkey ';5C' vi-forward-word
bindkey ';5D' vi-backward-word
bindkey ';6C' forward-word 
bindkey ';6D' backward-word 

# Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

# Color Scheme
cat ~/.cache/wal/sequences

alias ls='ls --color=auto'
alias grep='grep -i'
alias vim='nvim'
alias mkdir="mkdir -p"
alias la="ls -a"
alias ra="rm -r"

#PS1="\[\033[0;34m\] \W \[\033[0;32m\]\$ \[\033[0m\]"

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' formats ' %s(%F{green}%b%f)' # git(main)

PS1=" %F{blue}%~%f %F{green}$%f "
