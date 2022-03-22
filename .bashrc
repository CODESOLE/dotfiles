# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
else
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1

# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
# GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules
# GIT_PROMPT_WITH_VIRTUAL_ENV=0 # uncomment to avoid setting virtual environment infos for node/python/conda environments

GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
GIT_PROMPT_SHOW_UNTRACKED_FILES=normal # can be no, normal or all; determines counting of untracked files

# GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

# GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

# GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
# GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
# GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
# GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
source ~/.bash-git-prompt/gitprompt.sh

PS1="\e[1;32m[\u@\h \w]\$\e[m "

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
alias v='nvim'
alias nivm='nvim'
alias nvm='nvim'
alias nmv='nvim'
alias niv='nvim'
alias nvi='nvim'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias genformat='clang-format -style=llvm -dump-config > .clang-format'
set -o vi
export EDITOR='nvim'
export VISUAL='nvim'
