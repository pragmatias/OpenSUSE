#!/bin/sh

update_zypper=$(zypper lu 2> /dev/null | tail -n +5 | wc -l)
#installed_zypper=$(zypper se -si 2> /dev/null | tail -n +6 | wc -l)

#echo -ne " Installed : ${installed_zypper}"

if [ "$update_zypper" -gt 0 ]; then
    #echo " - Update(s) : ${update_zypper}"
    echo " ${update_zypper} pkgs"
else
    echo ""
fi
