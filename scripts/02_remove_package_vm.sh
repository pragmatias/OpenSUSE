#!/bin/bash
#
# Delete package and clean the orphelines dependance

. 00_functions_install.sh


# Liste des paquets inutiles
pkg_list_remove=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/package_remove_vm.txt)

# Supprimer les paquets inutiles 
for pkg_remove in ${pkg_list_remove}; do
  if rpm -q ${pkg_remove} 2>&1 > /dev/null ; then
	exec_cmd="zypper --non-interactive remove --clean-deps ${pkg_remove}"
	msg_log="deleting the package ${pkg_remove}"
	logMessage "-1" "${msg_log}... [${exec_cmd}]"
	${exec_cmd} >> $LOG 2>&1
	logMessage "${?}" "${msg_log}"
  fi
done

exit 0
