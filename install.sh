#!/usr/bin/sh

if [ -z "$1" ]
then
  echo "Please enter dist name (eg. deb, void, arch)" && exit 1
elif [ "$1" = "deb" ]
then
  sudo apt install fonts-inconsolata xclip neovim ninja-build build-essentials cmake
elif [ "$1" = "void" ]
then
  sudo xbps-install -S font-inconsolata-otf xclip neovim ninja cmake base-devel zoxide xst dmenu
elif [ "$1" = "arch" ]
then
  sudo pacman -S ttf-inconsolata xclip neovim ninja cmake base-devel
fi

cp -i .profile .Xresources .bash_profile .bashrc .vimrc .xinitrc ~/

chmod +x vpaste.sh && sudo cp -i vpaste.sh /usr/bin/vpaste.sh

if [ -x "$(command -v nvim)" ]
then
  sudo cp -i ./moonfly.vim /usr/share/nvim/runtime/colors/moonfly.vim
  mkdir -p ~/.config/nvim/pack/site/start
  cp ./init.vim ~/.config/nvim/init.vim
  cd ~/.config/nvim/pack/site/start && git clone https://github.com/hrsh7th/cmp-nvim-lsp https://github.com/hrsh7th/cmp-vsnip https://github.com/hrsh7th/nvim-cmp https://github.com/neovim/nvim-lspconfig https://github.com/nvim-treesitter/nvim-treesitter https://github.com/hrsh7th/vim-vsnip
fi

if [ -x "$(command -v vis)" ]
then
  mkdir -p ~/.config/vis/themes
  cp ./visrc.lua ~/.config/vis/visrc.lua
  cp ./seti.lua ~/.config/vis/themes/seti.lua
fi
