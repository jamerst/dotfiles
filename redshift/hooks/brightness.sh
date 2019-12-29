#!/bin/bash

# Set brightness for DDC/CI enabled monitors
# Originally by rnhmjoj, modified slightly by jamerst
# https://github.com/jonls/redshift/issues/436#issuecomment-366402503

# Place in ~/.config/redshift/hooks
# See HOOKS section under man page of redshift for more information about redshift hooks

# brightness values for each period (transition is brightness inbetween, not transition time)
night=0
transition=5
daytime=50


deref() {
  eval "echo \$$1"
  # get value of correct variable by name, i.e. if transitioning to night, get value of night variable
}

fade_to() {
  current=$(ddcutil get 10 | cut -d, -f1 | cut -d= -f2)
  [ "$current" -gt "$1" ] && step=-1 || step=1
  # set dim direction based on current brightness being greater or less than target
  for i in $(seq "$current" "$step" "$1"); do
    # step brightness down 1 level at a time
    ddcutil set 10 $i -d 1
    ddcutil set 10 $i -d 2
    sleep $2
  done
}


# if hook is for period changing
if [ "$1" = "period-changed" ]; then
  # if changing at startup, i.e. not fading between states
  if [ "$2" = "none" ]; then
    fade_to "$(deref "$3")" 0.5
  else
    fade_to "$(deref "$3")" 60
  fi
fi