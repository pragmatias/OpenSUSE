#!/bin/bash
killall -9 conky

conky -x -1980 -c $HOME/.config/conky/shortcut.conkyrc 

#sleep 5
#killall -9 conky