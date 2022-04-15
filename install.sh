#!/usr/bin/sh

cp -f .profile .Xresources .bash_profile .bashrc .vimrc .xinitrc ~/
chmod +x vpaste.sh && sudo cp -f vpaste.sh /usr/bin/vpaste.sh

if [ -z "$1" ]; then
  echo "Please enter dist name (eg. deb, void, arch)" && exit 1
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
fi

if [ -x "$(command -v nvim)" ]; then
  wget -O- -q https://raw.githubusercontent.com/bluz71/vim-moonfly-colors/master/colors/moonfly.vim > moonfly.vim
  sudo cp -f ./moonfly.vim /usr/share/nvim/runtime/colors/moonfly.vim
  mkdir -p ~/.config/nvim/pack/site/start
  cp ./init.vim ~/.config/nvim/init.vim
  cd ~/.config/nvim/pack/site/start &&\
  git clone https://github.com/ray-x/lsp_signature.nvim &&\
  git clone https://github.com/hrsh7th/nvim-compe &&\
  git clone https://github.com/neovim/nvim-lspconfig &&\
  git clone https://github.com/nvim-treesitter/nvim-treesitter &&\
  git clone https://github.com/easymotion/vim-easymotion.git
fi

if [ -x "$(command -v vis)" ]; then
  mkdir -p ~/.config/vis/themes
  cp ./visrc.lua ~/.config/vis/visrc.lua
  cp ./seti.lua ~/.config/vis/themes/seti.lua
fi
