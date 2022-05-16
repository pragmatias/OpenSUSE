#!/bin/bash

MENU="$(rofi -theme ~/.config/rofi/gowy_menu_power.rasi -sep "|" -dmenu -i -p 'System' <<< "⏼   Lock|   Logout|   Reboot|⏻   Shutdown")"
            case "$MENU" in
                *Lock) cd ~/.config/polybar && ./i3lock_fancy.sh ;;
                *Logout) i3-msg exit ;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff
            esac 

