#!/bin/bash

# Set wallpaper based on current time
# Based on a script for setting display brightness by rnhmjoj
# https://github.com/jonls/redshift/issues/436#issuecomment-366402503

# Place in ~/.config/redshift/hooks
# See HOOKS section under man page of redshift for more information about redshift hooks

# path to wallpaper for each time
daytime='/home/jtattersall/Pictures/backgrounds/lis ep2 menu.png'
transition='/home/jtattersall/Pictures/backgrounds/lis ep4 menu.png'
night='/home/jtattersall/Pictures/backgrounds/lis ep3 menu.png'


deref() {
  eval "echo \$$1"
  # get value of correct variable by name, i.e. if transitioning to night, get value of night variable
}


if [ "$1" = "period-changed" ]; then
  # if hook is for period changing
  gsettings set org.cinnamon.desktop.background picture-uri "file://$(deref "$3")"
fi