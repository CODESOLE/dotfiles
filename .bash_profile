#
# ~/.bash_profile
#

export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export RUSTC_WRAPPER=sccache
export PS1="\[\e[38;5;9m\]\u\[\e[38;5;14m\]@\[\e[38;5;5m\]\h \[\e[38;5;10m\]\w \[\033[0m\]$ "
if [ "$INSIDE_EMACS" ]; then
    export PS1='\u@\h:\w\$ '
fi
[[ -f ~/.bashrc ]] && . ~/.bashrc
