#!/bin/bash
killall -9 polybar

conky -c $HOME/.config/conky/vm_topleft.conkyrc

