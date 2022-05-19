#!/usr/bin/sh

cp -f .profile .Xresources .bash_profile .bashrc .vimrc .xinitrc ${HOME}
chmod +x vpaste.sh && sudo cp -f vpaste.sh /usr/bin/vpaste.sh

if [ -z "$1" ]; then
  echo "Please enter run type (eg. deb, void, arch, vis, nvim)" && exit 1
elif [ "$1" = "deb" ]; then
  sudo apt -y install xclip neovim ninja-build build-essentials cmake ccls wget
elif [ "$1" = "void" ]; then
  sudo xbps-install -S -y xclip vis neovim ninja premake5 meson cmake base-devel xst autojump dmenu ccls xorg xinit wget base-devel libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel
  git clone https://git.suckless.org/dwm && rm -f ./dwm/config.def.h && cp -f ./config.def.h ./dwm/config.def.h && cd ./dwm/ && sudo make clean install && cd ..
  git clone https://git.suckless.org/slstatus && rm -f ./slstatus/config.def.h && cp -f ./config.h ./slstatus/config.def.h && cd ./slstatus/ && sudo make clean install
elif [ "$1" = "arch" ]; then
  sudo pacman -S --noconfirm xclip neovim vis ninja cmake base-devel dmenu premake meson ccls xorg xorg-xinit wget base-devel libx11 libxft libxinerama freetype2 fontconfig
  git clone https://aur.archlinux.org/xst-git && cd xst-git/ && makepkg -si && cd ..
  git clone https://aur.archlinux.org/autojump && cd autojump/ && makepkg -si && cd ..
  git clone https://git.suckless.org/dwm && rm -f ./dwm/config.def.h && cp -f ./config.def.h ./dwm/config.def.h && cd ./dwm/ && sudo make clean install && cd ..
  git clone https://git.suckless.org/slstatus && rm -f ./slstatus/config.def.h && cp -f ./config.h ./slstatus/config.def.h && cd ./slstatus/ && sudo make clean install
elif [ "$1" = "nvim" ] && [ -x "$(command -v nvim)" ]; then
  mkdir -p ${HOME}/.config/nvim/pack/site/start
  cp ./init.vim ${HOME}/.config/nvim/init.vim
  cd ${HOME}/.config/nvim/pack/site/start &&\
  git clone https://github.com/neovim/nvim-lspconfig &&\
  git clone https://github.com/nvim-treesitter/nvim-treesitter &&\
  git clone https://github.com/easymotion/vim-easymotion.git &&\
  git clone https://github.com/mg979/vim-visual-multi.git &&\
  git clone https://github.com/lewis6991/gitsigns.nvim &&\
  git clone https://github.com/nvim-lua/plenary.nvim &&\
  git clone https://github.com/TimUntersberger/neogit &&\
  git clone https://github.com/kyazdani42/nvim-tree.lua &&\
  git clone https://github.com/mg979/docgen.vim.git &&\
  git clone https://github.com/gpanders/editorconfig.nvim
elif [ "$1" = "vis" ] && [ -x "$(command -v vis)" ]; then
  mkdir -p ${HOME}/.config/vis/themes
  cp ./visrc.lua ${HOME}/.config/vis/visrc.lua
  cp ./seti.lua ${HOME}/.config/vis/themes/seti.lua
fi
