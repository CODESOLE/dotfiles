#
# ~/.bash_profile
#

export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export RUSTC_WRAPPER=sccache

[[ -f ~/.bashrc ]] && . ~/.bashrc
