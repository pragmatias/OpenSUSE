#!/bin/bash
killall -9 conky

conky -c $HOME/.config/conky/user.conkyrc

