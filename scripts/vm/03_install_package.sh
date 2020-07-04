#!/bin/bash
#
# Install package

. ../00_functions_install.sh

# Liste des paquets supplémentaires
pkg_list_add=$(egrep -v '(^\#)|(^\s+$)' $CWD/../../config/pkglists/package_install_vm.txt)

# Installer les paquets supplémentaires
for pkg_add in ${pkg_list_add}; do
  if ! rpm -q ${pkg_add} 2>&1 > /dev/null ; then
	exec_cmd="zypper --non-interactive install --no-recommends ${pkg_add}"
	msg_log="Install of the package ${pkg_add}"
	logMessage "-1" "${msg_log}... [${exec_cmd}]"
	${exec_cmd} >> $LOG 2>&1
	logMessage "${?}" "${msg_log}"
  fi
done

exit 0

