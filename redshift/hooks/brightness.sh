#!/bin/bash
exit 0
# Set brightness for DDC/CI enabled monitors using brightnessd

# Place in ~/.config/redshift/hooks
# See HOOKS section under man page of redshift for more information about redshift hooks

# brightness values for each period (transition is brightness inbetween, not transition time)
night=5
transition=10
daytime=50


deref() {
  eval "echo \$$1"
  # get value of correct variable by name, i.e. if transitioning to night, get value of night variable
}

fade_to() {
  dbus-send --print-reply --dest=net.jtattersall.brightness /net/jtattersall/brightness net.jtattersall.brightness.Stop
  dbus-send --print-reply --dest=net.jtattersall.brightness /net/jtattersall/brightness net.jtattersall.brightness.Fade int32:$1 int32:$2
}

# if hook is for period changing
if [ "$1" = "period-changed" ]; then
  # if changing at startup, i.e. not fading between states
  if [ "$2" = "none" ]; then
    fade_to "$(deref "$3")" 15
  else
    fade_to "$(deref "$3")" 3600
  fi
fi