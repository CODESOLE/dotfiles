#!/usr/bin/env bash

if [ "$(pwd)" = "${HOME}/.config/nvim/pack/site/start" ]; then
  n=$(find `pwd` -maxdepth 1 -mindepth 1 -type d | wc -l)
  readarray -t x <<<"$(find `pwd` -maxdepth 1 -mindepth 1 -type d))"
  for ((i=0; i < $n; i++))
  do
    echo -e "\033[34;1;4m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${x[i]}\033[0m"
    cd ${x[i]} && git pull && cd ..
  done
else
  echo -e "\033[31;1mThis script should be run in ${HOME}/.config/nvim/pack/site/start\033[0m"
  exit 1
fi
