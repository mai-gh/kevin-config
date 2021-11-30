#!/bin/sh

while true; do
  STATUS=''
  TIME="$(date +'%a %b %d %R:%S')"
  CHARGE="$(acpi | sed 's/.*: \(.*%\).*/\1/g')"
  MEM="$(free -m | grep Mem: | awk '{print $7}')M"
  WINDOW="$(swaymsg -t get_tree | grep -A30 '"focused": true,' | grep name | awk -F'"' '{print $4}')"
  WORKSPACE="$(swaymsg -t get_tree | grep current_workspace | awk -F'"' '{print $4}')"
  SOUND=''
  WLAN=''
  HDD=''


  STATUS="$WORKSPACE | $WINDOW | $MEM | $CHARGE | $TIME |"
  echo -e "$STATUS"
  sleep 1
done
