#!/bin/bash
killall -9 polybar

conky -c $HOME/.config/conky/user.conkyrc

