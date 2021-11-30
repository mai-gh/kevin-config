#/bin/bash

# set the following in /etc/systemd/logind.conf
#    HandlePowerKey=ignore
# then run this ro refresh that setting
#    # systemctl restart systemd-logind
# then add this to your sway config
#    bindsym XF86PowerOff exec /home/main/scripts/sway-rotate-button.sh
# *** make sure sway-rotate-button.sh is executable!


#set -x


TSTATE=$(swaymsg -t get_outputs | grep transform | awk -F'"' '{print $4}')
if [ $TSTATE == 'normal' ]; then
  TSTATE=0
fi

NEW_TSTATE=$(($TSTATE + 90))


if [ $NEW_TSTATE == 90 ]; then
  swaymsg output eDP-1 transform 90
  swaymsg input "0:0:cros_ec" events disabled
  swaymsg input "type:touchpad" events disabled
elif [ $NEW_TSTATE == 180 ]; then
  swaymsg output eDP-1 transform 180
  swaymsg input "0:0:cros_ec" events disabled
  swaymsg input "type:touchpad" events disabled
elif [ $NEW_TSTATE == 270 ]; then
  swaymsg output eDP-1 transform 270
  swaymsg input "0:0:cros_ec" events disabled
  swaymsg input "type:touchpad" events disabled
elif [ $NEW_TSTATE == 360 ]; then
  swaymsg output eDP-1 transform 0
  swaymsg input "0:0:cros_ec" events enabled
  swaymsg input "type:touchpad" events enabled
fi

