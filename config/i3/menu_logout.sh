#!/bin/bash

MENU="$(rofi -theme ~/.config/rofi/gruvbox-dark.rasi -sep "|" -dmenu -i -p 'System' -location 0 -width 25 -hide-scrollbar -line-padding 4 -padding 10 -lines 4 -font "SF Compact Display, Ubuntu Nerd Font 12" <<< "⏼ Lock| Logout| Reboot|⏻ Shutdown")"
            case "$MENU" in
                *Lock) cd ~/.config/polybar && ./i3lock_fancy.sh ;;
                *Logout) i3-msg exit ;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff
            esac 

