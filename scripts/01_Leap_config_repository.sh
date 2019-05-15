#!/bin/bash
#
# Create a list of Leap repositories (with packman)
# Automatic import of GPG Key
# Refresh repository and Update package

. 00_functions_install.sh

echo


. 00_functions_install.sh
. 00_Leap_environment.sh

# Suppression des dépôts existants
exec_cmd="rm -f /etc/zypp/repos.d/*.repo"
msg_log="Removal of existing repository"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [oss]
exec_cmd="zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/oss oss"
msg_log="Repository configuration [oss]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [non-oss]
exec_cmd="zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/non-oss non-oss"
msg_log="Repository configuration [non-oss]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [oss-updates]
exec_cmd="zypper addrepo $MIRROR/update/leap/$VERSION/oss oss-updates"
msg_log="Repository configuration [oss-updates]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [non-oss-updates]
exec_cmd="zypper addrepo $MIRROR/update/leap/$VERSION/non-oss non-oss-updates"
msg_log="Repository configuration [non-oss-updates]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [packman]
exec_cmd="zypper addrepo --priority 90 $PACKMAN packman"
msg_log="Repository configuration [packman]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [dvdcss]
exec_cmd="zypper addrepo $DVDCSS dvdcss"
msg_log="Repository configuration [dvdcss]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [obs]
exec_cmd="zypper addrepo --priority 105 ${OBS} obs"
msg_log="Repository configuration [obs]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [kde-extra]
exec_cmd="zypper addrepo --priority 100 $KDEXTRA kde"
msg_log="Repository configuration [kde-extra]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Configuration du dépôt [SublimeText]
exec_cmd="rpm -v --import $SUBLIMETEXT/sublimehq-rpm-pub.gpg"
msg_log="Repository configuration [SublimeText] (gpg key)"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"

exec_cmd="zypper addrepo -g -f $SUBLIMETEXT/rpm/dev/x86_64/sublime-text.repo"
msg_log="Repository configuration [SublimeText]"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Synchronisation et import des clés GPG
exec_cmd="zypper --gpg-auto-import-keys refresh"
msg_log="Synchronization and import of the GPG Keys"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"


# Mise à jour des paquets
exec_cmd="zypper --non-interactive update"
msg_log="Package update"
logMessage "-1" "${msg_log}... [${exec_cmd}]"
${exec_cmd} >> $LOG 2>&1
logMessage "${?}" "${msg_log}"

exit 0

