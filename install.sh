#!/usr/bin/sh

if [ -z "$1" ]; then
  echo "Please enter dist name (eg. deb, void, arch)" && exit 1
elif [ "$1" = "deb" ]; then
  sudo apt -y install xclip neovim ninja-build build-essentials cmake ccls
elif [ "$1" = "void" ]; then
  sudo xbps-install -S -y xclip vis neovim ninja cmake base-devel xst autojump dmenu ccls
elif [ "$1" = "arch" ]; then
  sudo pacman -S --noconfirm xclip neovim vis ninja cmake base-devel dmenu premake meson ccls
  git clone https://aur.archlinux.org/xst-git && cd xst-git/ && makepkg -si
  git clone https://aur.archlinux.org/autojump && cd autojump/ && makepkg -si
  git clone https://git.suckless.org/dwm && && rm -f ./dwm/config.def.h && cp -f ./config.def.h ./dwm/config.def.h && sudo make clean install
fi

cp -f .profile .Xresources .bash_profile .bashrc .vimrc .xinitrc ~/
cp -f HackRegularNerdFontCompleteMono.ttf /usr/share/fonts/HackRegularNerdFontCompleteMono.ttf
sudo fc-cache -f -v
chmod +x vpaste.sh && sudo cp -f vpaste.sh /usr/bin/vpaste.sh

if [ -x "$(command -v nvim)" ]; then
  sudo cp -f ./moonfly.vim /usr/share/nvim/runtime/colors/moonfly.vim
  mkdir -p ~/.config/nvim/pack/site/start
  cp ./init.vim ~/.config/nvim/init.vim
  cd ~/.config/nvim/pack/site/start &&\
  git clone https://github.com/ray-x/lsp_signature.nvim &&\
  git clone https://github.com/hrsh7th/nvim-compe &&\
  git clone https://github.com/neovim/nvim-lspconfig &&\
  git clone https://github.com/nvim-treesitter/nvim-treesitter

fi

if [ -x "$(command -v vis)" ]; then
  mkdir -p ~/.config/vis/themes
  cp ./visrc.lua ~/.config/vis/visrc.lua
  cp ./seti.lua ~/.config/vis/themes/seti.lua
fi
