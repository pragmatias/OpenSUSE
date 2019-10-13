#!/bin/bash
killall -9 conky

conky -c $HOME/.config/conky/vm_left.conkyrc

conky -c $HOME/.config/conky/vm_right.conkyrc

