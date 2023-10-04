# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep -i'

PS1="\[\033[0;34m\] \W \[\033[0;32m\]\$ \[\033[0m\]"
