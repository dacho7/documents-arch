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

# start wallpaper
var=$(shuf -i0-3 -n1)
var="Images/wallpaper/"$var".jpg"
feh --bg-fill $var &

# start dwm
exec dwm &

# start menu bar
while true; do
  bat=$(acpi | tr " " "," | awk -F"," '{print $3}')
  battery=$(acpi | awk -F"," '{print $2}')
  if [ $bat = "Charging" ];
  then
    battery=" "$battery
  fi
  wifi=$(iw dev | grep "ssid" | awk -F" " '{print $2}')
  hora=$(date | awk -F" " '{print $4}' | awk -F":" '{print $1":"$2}')
  datenow=$(date | awk -F" " '{print $2"/"$3}')
  xsetroot -name "  $wifi |  $datenow $hora |$battery"
  sleep 1m
done

# restart dwm startx
#while true; do
#  dwm >/dev/null 2>&1
#done


