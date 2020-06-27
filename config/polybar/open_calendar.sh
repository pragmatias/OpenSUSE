#!/bin/sh

WIDTH=270
HEIGHT=274
BOTTOM=false
DATE="$(date +"  %A, %d/%m/%Y   %H:%M ")"

case "$1" in
    --popup)
        eval "$(xdotool getmouselocation --shell)"
        DATE="$(date +"%H:%M")"

        if [ $BOTTOM = true ]; then
            : $(( pos_y = Y - HEIGHT - 20 ))
            : $(( pos_x = X - (WIDTH / 2) ))
        else
            : $(( pos_y = Y + 20 ))
            : $(( pos_x = X - (WIDTH / 2) ))
        fi

        urxvt -geometry 40x20+$pos_x+$pos_y -fn "xft:Hack Nerd Font:size=8" --title calendar_popup -e dialog --no-shadow --no-cancel --week-start 1 --clear --calendar "Time : $DATE" 2 40

        ;;
    *)
        echo "$DATE"
        ;;
esac