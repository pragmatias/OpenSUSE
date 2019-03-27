# functions_install_TW.sh
#
# Opérations communes à tous les scripts de ce répertoire

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo ":: You need to be root to execute this script."
  exit 1
fi

# Répertoire courant
CWD=$(pwd)

# Journal
LOG=/tmp/$(basename "$0" .sh).log

# Nettoyer le fichier journal
echo > $LOG

# Interrompre en cas d'erreur
set -e

# Miroirs de téléchargement
MIRROR="http://download.opensuse.org"
NVIDIA="https://download.nvidia.com/opensuse/tumbleweed/"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"
DVDCSS="http://opensuse-guide.org/repo/openSUSE_Tumbleweed/"
SUBLIMETEXT="https://download.sublimetext.com"

# Couleurs
VERT="\033[01;32m"
ROUGE="\033[00;33m"
GRIS="\033[00m"
BLANC="\033[01;37m"

# Pause entre les opérations
DELAY=1


function logMessage () {
    #gestion des parametres
    coderetour=$1
    message=$2

    type="INF"
    message_sup=""
    statut_date=`date "+%Y-%m-%d"`
    statut_time=`date "+%H:%M:%S"`

    if [ ${coderetour} -gt 0 ]
    then 
    	type="ERR"
    	message_sup=" [${ROUGE}KO${GRIS}]"
    elif [ ${coderetour} -eq 0 ]
    then
    	type="INF"
    	message_sup=" [${VERT}OK${GRIS}]"
    else
    	type="INF"
    	message_sup=""
    fi

    #affichage du message dans la sortie courante
    echo -e "${statut_date} ${statut_time} - ${type} - ${message}${message_sup}" >> ${LOG}
    echo -e "${statut_date} ${statut_time} - ${type} - ${message}${message_sup}"
    if [ ${coderetour} -gt 0 ]
    then
    	echo -e "${statut_date} ${statut_time} - ERR - log detail [${LOG}]"
    	exit ${coderetour}
    fi

}

