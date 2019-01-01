#!/bin/bash
#
# Create a list of Tumebleweed repositories (with packman)
# Automatic import of GPG Key
# Refresh repository and Update package

. functions_install_TW.sh

# Suppression des dépôts existants
echo
echo -e ":: Removal of existing repository... \c"
sleep $DELAY
rm -f /etc/zypp/repos.d/*.repo
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [oss]
echo -e ":: Repository configuration [oss]... \c"
zypper addrepo $MIRROR/tumbleweed/repo/oss oss >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [non-oss]
echo -e ":: Repository configuration [non-oss]... \c"
zypper addrepo $MIRROR/tumbleweed/repo/non-oss non-oss >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [oss-updates]
echo -e ":: Repository configuration [oss-updates]... \c"
zypper addrepo $MIRROR/update/tumbleweed oss-updates >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [nvidia]
echo -e ":: Repository configuration [nvidia]... \c"
zypper addrepo $NVIDIA nvidia >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [packman]
echo -e ":: Repository configuration [packman]... \c"
zypper addrepo --priority 90 $PACKMAN packman >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [dvdcss]
echo -e ":: Repository configuration [dvdcss]... \c"
zypper addrepo $DVDCSS dvdcss >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Configuration du dépôt [SublimeText]
echo -e ":: Repository configuration [SublimeText]... \c"
rpm -v --import $SUBLIMETEXT/sublimehq-rpm-pub.gpg >> $LOG 2>&1
zypper addrepo -g -f $SUBLIMETEXT/rpm/dev/x86_64/sublime-text.repo >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi


# Synchronisation et import des clés GPG
echo -e ":: Synchronization and import of the GPG Keys... \c"
zypper --gpg-auto-import-keys refresh >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Mise à jour des paquets
echo "::"
echo -e ":: Package update... \c"
zypper --non-interactive update --allow-vendor-change >> $LOG 2>&1
if [ $? -eq 0 ]; then ok ; else ko ; fi

echo

exit 0

