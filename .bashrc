#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export PS1="\e[1;32m[\u@\h \W]\$ \e[m "

alias evi='vim ~/.vimrc'
alias ebs='vim ~/.bashrc'
alias c='clear'
alias e='exit'
alias ..='cd ..'
alias ..='cd ../../'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias genfgnu='clang-format -style=gnu -dump-config > .clang-format'
alias genfmic='clang-format -style=microsoft -dump-config > .clang-format'
alias v='vim'
set -o vi
export EDITOR='vim'
export VISUAL='vim'
