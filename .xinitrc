#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

get_cpu(){
  top -bn1 | sed -n '/Cpu/p' | awk '{print (100 - $8)}'
}

get_ram(){
  echo "$(free -m | sed -n '/Mem/p' | awk '{print $3}')M"
}

get_gpu(){
  nvidia-smi | sed -n '/| N\//p' | awk '{print $13}'
}

get_vram(){
  nvidia-smi | sed -n '/| N\//p' | awk '{print $9}'
}

get_date(){
  date | awk '{print $1, $2, $3, $4}'
}

get_vol(){
  pactl list sinks | awk '/Volume: front-left/{print $5}'
}

get_status(){
	while true;do
	  xsetroot -name "CPU:%$(get_cpu) | RAM:$(get_ram) | $(get_date)"
	  sleep 1
	done
}

get_status &
xrandr -s 1366x768
setxkbmap tr
nitrogen --restore  &
exec dwm
