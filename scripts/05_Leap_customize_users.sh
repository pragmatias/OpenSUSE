#!/bin/bash
#
# Customization of Bash, ZSH and VIM

. 00_functions_install.sh


# Personnalisation du shell Bash pour root
msg_log="Customization of the shell Bash for root"
logMessage "-1" "${msg_log}..."
cat $CWD/../config/bash/root-bashrc > /root/.bashrc
logMessage "${?}" "${msg_log}"


# Personnalisation du shell Bash pour les utilisateurs
msg_log="Customization of the shell Bash for users"
logMessage "-1" "${msg_log}..."
cat $CWD/../config/bash/user-alias > /etc/skel/.alias
if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cat $CWD/../config/bash/user-alias > /home/$UTILISATEUR/.alias
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.alias
	if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"


# Personnalisation de l'editeur VIM pour les utilisateurs
msg_log="Customization of the editor VIM for users"
logMessage "-1" "${msg_log}..."
cat $CWD/../config/vim/vimrc > /etc/skel/.vimrc
if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cat $CWD/../config/vim/vimrc > /home/$UTILISATEUR/.vimrc
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.vimrc
	if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"


# Personnalisation de Neofetch pour les utilisateurs (info)
msg_log="Customization of Neofetch for users"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.config/neofetch ]; then
      mkdir /home/$UTILISATEUR/.config/neofetch
      if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/.config/neofetch
    fi
    cp $CWD/../config/neofetch/* /home/$UTILISATEUR/.config/neofetch/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/neofetch
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



# Copie wallpapers
msg_log="Copy wallpapers in Pictures folder for users"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/Pictures ]; then
      mkdir /home/$UTILISATEUR/Pictures
      if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/Pictures
    fi
    cp $CWD/../wallpapers/* /home/$UTILISATEUR/Pictures/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/Pictures
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



# Personnalisation de conky
msg_log="Customization of Conky"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.config/conky ]; then
        mkdir /home/$UTILISATEUR/.config/conky
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/conky
    fi
    cp $CWD/../config/conky/*.conkyrc /home/$UTILISATEUR/.config/conky/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/conky
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    if [ ! -e /home/$UTILISATEUR/.config/autostart-scripts ]; then
      mkdir /home/$UTILISATEUR/.config/autostart-scripts
      if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/.config/autostart-scripts
    fi
    cp $CWD/../config/conky/start_conky.sh /home/$UTILISATEUR/.config/autostart-scripts/start_conky.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chmod +x /home/$UTILISATEUR/.config/autostart-scripts/start_conky.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.config/autostart-scripts/start_conky.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



#alacrity etc ....

exit 0
