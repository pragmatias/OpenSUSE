#!/bin/bash
#
# Install package

. functions_install_TW.sh

# Liste des paquets supplémentaires
EXTRAS=$(egrep -v '(^\#)|(^\s+$)' \
  $CWD/../config/pkglists/package_install.txt)

# Installer les paquets supplémentaires
echo
for PAQUET in $EXTRAS; do
  if ! rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Install of the package $PAQUET... \c"
    zypper --non-interactive install --no-recommends $PAQUET >> $LOG 2>&1
    if [ $? -eq 0 ]; then ok ; else ko ; fi
  fi
done

echo

exit 0
