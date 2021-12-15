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
#var=$(shuf -i0-3 -n1)
#var="Documents/images/wallpaper/"$var".jpg"
var="Documents/wallpaper/fondo.jpg"
feh --bg-fill $var &

# start dwm
exec dwm &

# start menu bar
while true; do
  hora=$(date | awk -F" " '{print $4}' | awk -F":" '{print $1":"$2}')
  datenow=$(date | awk -F" " '{print $2" "$3}')
  user=$(who | cut -d " " -f 1)
  cpu=$(top -bn1 | grep Cpu | awk '{print $2}')
  memory=$(top -bn1 | grep "MiB Mem" | awk '{print $8}')
  storage=$(df -H | grep /dev/sda2 | awk '{print $4}')
  xsetroot -name "  $user |  $storage |  Cpu: $cpu% |  Ram: $memory Mb/s |  $datenow $hora "
  sleep 1s
done

# restart dwm startx
#while true; do
#  dwm >/dev/null 2>&1
#done


