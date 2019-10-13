#!/bin/bash
#
# Sytem config

. 00_functions_install.sh

# Force the OnlyRequires mode for Zypper
sed -i 's@solver.OnlyRequires = false@solver.OnlyRequires = true@' /etc/zypp/zypp.conf

# Modify the display manager to LightDM
sed -i 's@DISPLAYMANAGER=".*"@DISPLAYMANAGER="lightdm"@' /etc/sysconfig/displaymanager

# Modify the graphical.targer
systemctl set-default graphical.target

# Test some tuning
systemctl disable btrfsmaintenance-refresh
systemctl disable chrony-wait