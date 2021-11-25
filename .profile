if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

alias evi='vim ~/.vimrc'
alias ebs='vim ~/.bashrc'
alias c='clear'
alias e='exit'
alias ..='cd ..'
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
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
set -o vi
export EDITOR='nvim'
export VISUAL='nvim'
