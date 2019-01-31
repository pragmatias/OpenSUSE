# source.sh
#
# Opérations communes à tous les scripts de ce répertoire

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo ":: You need to be root to execute this script."
  exit 1
fi

# Répertoire courant
CWD=$(pwd)

# Interrompre en cas d'erreur
set -e

# Version
VERSION=15.0

# Miroirs de téléchargement
MIRROR="http://download.opensuse.org"
NVIDIA="https://download.nvidia.com"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_${VERSION}/"
KDEXTRA="https://download.opensuse.org/repositories/KDE:/Extra/openSUSE_Leap_${VERSION}/"
DVDCSS="http://opensuse-guide.org/repo/openSUSE_Leap_${VERSION}/"
SUBLIMETEXT="https://download.sublimetext.com"

# Couleurs
VERT="\033[01;32m"
ROUGE="\033[00;33m"
GRIS="\033[00m"
BLANC="\033[01;37m"

# Pause entre les opérations
DELAY=1

# Afficher [OK] en cas de succès
function ok () {
    echo -e "[${VERT}OK${GRIS}] \c"
  	sleep $DELAY
  	echo
}

function ko () {
  	echo -e "[${ROUGE}KO${GRIS}] \c"
  	sleep $DELAY
  	echo
  	exit ${cr_tmp}
}

# Journal
LOG=/tmp/$(basename "$0" .sh).log

# Nettoyer le fichier journal
echo > $LOG

