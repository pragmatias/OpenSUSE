#!/bin/bash
#
# Delete package and clean the orphelines dependance

. 00_functions_install.sh


# Liste des paquets inutiles
pkg_list_remove=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/package_remove_desktop.txt)

# Supprimer les paquets inutiles 
for pkg_remove in ${pkg_list_remove}; do
  if rpm -q ${pkg_remove} 2>&1 > /dev/null ; then
	exec_cmd="zypper --non-interactive remove --clean-deps ${pkg_remove}"
	msg_log="deleting the package ${pkg_remove}"
	logMessage "-1" "${msg_log}... [${exec_cmd}]"
	${exec_cmd} >> $LOG 2>&1
	logMessage "${?}" "${msg_log}"
  fi

  lock_exist=$(zypper ll | grep ${pkg_remove} | wc -l)
  if [ ${lock_exist} -eq 0 ] ; then
	exec_cmd="zypper --non-interactive addlock ${pkg_remove}"
	msg_log="locking the package ${pkg_remove}"
	logMessage "-1" "${msg_log}... [${exec_cmd}]"
	${exec_cmd} >> $LOG 2>&1
	logMessage "${?}" "${msg_log}"
  fi
  
done

exit 0
