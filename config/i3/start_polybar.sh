#!/bin/bash

killall -9 polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# if type "xrandr" > /dev/null
# then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
# 	MONITOR=$m polybar --reload top -c ~/.config/polybar/config &
# 	if [ "${1}" != "top" ]
# 	then
# 		MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config &
# 	fi
#   done
# else
# 	polybar --reload top -c ~/.config/polybar/config &
# fi

if [ "${1}" == "top" ]
then
	polybar --reload top1 -c ~/.config/polybar/config &
else
	polybar --reload top1 -c ~/.config/polybar/config &
	polybar --reload top2 -c ~/.config/polybar/config &
fi

