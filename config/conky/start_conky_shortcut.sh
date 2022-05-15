#!/bin/bash
killall -9 conky

conky -c $HOME/.config/conky/shortcut.conkyrc 
conky -x 2560 -c $HOME/.config/conky/shortcut.conkyrc 

sleep 5
killall -9 conky