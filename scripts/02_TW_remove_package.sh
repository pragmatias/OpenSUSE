#!/bin/bash
#
# Delete package and clean the orphelines dependance

. functions_install_TW.sh


# Liste des paquets inutiles
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' \
  $CWD/../config/pkglists/package_remove.txt)

# Supprimer les paquets inutiles 
echo
for PAQUET in $CHOLESTEROL; do
  if rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: deleting the package $PAQUET... \c"
    zypper --non-interactive remove --clean-deps $PAQUET >> $LOG 2>&1
    if [ $? -eq 0 ]; then ok ; else ko ; fi
  fi
done

echo

exit 0
