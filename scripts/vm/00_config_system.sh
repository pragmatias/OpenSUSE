#!/bin/bash
#
# Sytem config

. ../00_functions_install.sh

# Force the OnlyRequires mode for Zypper
sed -i 's@# solver.onlyRequires = false@solver.onlyRequires = true@' /etc/zypp/zypp.conf
sed -i 's@# solver.OnlyRequires = false@solver.OnlyRequires = true@' /etc/zypp/zypp.conf
sed -i 's@solver.onlyRequires = false@solver.onlyRequires = true@' /etc/zypp/zypp.conf
sed -i 's@solver.OnlyRequires = false@solver.OnlyRequires = true@' /etc/zypp/zypp.conf
