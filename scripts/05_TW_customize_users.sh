#!/bin/bash
#
# Customization of Bash, ZSH and VIM

. functions_install_TW.sh

echo 

# Personnalisation du shell Bash pour root
echo -e ":: Customization of the shell Bash for root... \c"
sleep $DELAY
cat $CWD/../config/bash/root-bashrc > /root/.bashrc
if [ $? -eq 0 ]; then ok ; else ko ; fi

# Personnalisation du shell ZSH pour root
#echo -e ":: Customization of the shell ZSH for root... \c"
#sleep $DELAY
#cat $CWD/../config/zsh/zshrc  > /root/.zshrc
#if [ $? -eq 0 ]; then ok ; else ko ; fi


# Personnalisation du shell Bash pour les utilisateurs
echo -e ":: Customization of the shell Bash for users... \c"
sleep $DELAY
cat $CWD/../config/bash/user-alias > /etc/skel/.alias
if [ $? -ne 0 ]; then ko ; fi
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cat $CWD/../config/bash/user-alias > /home/$UTILISATEUR/.alias
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.alias
	if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok

# Personnalisation du shell zsh pour les utilisateurs
#echo -e ":: Customization of the shell ZSH for users... \c"
#sleep $DELAY
#cat $CWD/../config/zsh/zshrc > /etc/skel/.zshrc
#if [ $? -ne 0 ]; then ko ; fi
#if [ ! -z "$(ls -A /home)" ]; then
#  for UTILISATEUR in $(ls /home); do
#    cat $CWD/../config/zsh/zshrc  > /home/$UTILISATEUR/.zshrc
#    if [ $? -ne 0 ]; then ko ; fi
#    chown $UTILISATEUR:users /home/$UTILISATEUR/.zshrc
#	if [ $? -ne 0 ]; then ko ; fi
#  done
#fi
#ok


# Personnalisation de l'editeur VIM pour les utilisateurs
echo -e ":: Customization of the editor VIM for users... \c"
sleep $DELAY
cat $CWD/../config/vim/vimrc > /etc/skel/.vimrc
if [ $? -ne 0 ]; then ko ; fi
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cat $CWD/../config/vim/vimrc > /home/$UTILISATEUR/.vimrc
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.vimrc
	if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



# Personnalisation de latte_dock
echo -e ":: Customization of the latte-dock for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.config/latte ]; then
        mkdir /home/$UTILISATEUR/.config/latte
        if [ $? -ne 0 ]; then ko ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/latte
    fi
    cp $CWD/../config/latte/* /home/$UTILISATEUR/.config/latte/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/latte
	if [ $? -ne 0 ]; then ko ; fi
    cp $CWD/../config/lattedockrc /home/$UTILISATEUR/.config/lattedockrc
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.config/lattedockrc
	if [ $? -ne 0 ]; then ko ; fi
	if [ ! -e /home/$UTILISATEUR/.config/autostart ]; then
    mkdir /home/$UTILISATEUR/.config/autostart
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.config/autostart
  fi
  cp /usr/share/applications/org.kde.latte-dock.desktop /home/$UTILISATEUR/.config/autostart/org.kde.latte-dock.desktop
  if [ $? -ne 0 ]; then ko ; fi
  chown $UTILISATEUR:users /home/$UTILISATEUR/.config/autostart/org.kde.latte-dock.desktop
	if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok


# Personnalisation de Konsole pour les utilisateurs (colorscheme)
echo -e ":: Customization of Konsole for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.local/share/konsole ]; then
      mkdir /home/$UTILISATEUR/.local/share/konsole
      if [ $? -ne 0 ]; then ko ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/.local/share/konsole
    fi
    cp $CWD/../config/konsole/* /home/$UTILISATEUR/.local/share/konsole/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.local/share/konsole
    if [ $? -ne 0 ]; then ko ; fi
    cp $CWD/../config/konsolerc /home/$UTILISATEUR/.config/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/konsolerc
    if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



# Deactivate Kwallet
echo -e ":: Deactivate Kwallet subsystem for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cp $CWD/../config/kwalletrc /home/$UTILISATEUR/.config/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/kwalletrc
    if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok


# Personnalisation de Neofetch pour les utilisateurs (info)
echo -e ":: Customization of Neofetch for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.config/neofetch ]; then
      mkdir /home/$UTILISATEUR/.config/neofetch
      if [ $? -ne 0 ]; then ko ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/.config/neofetch
    fi
    cp $CWD/../config/neofetch/* /home/$UTILISATEUR/.config/neofetch/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/neofetch
    if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



# Copie wallpapers
echo -e ":: Copy wallpapers in Pictures folder for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/Pictures ]; then
      mkdir /home/$UTILISATEUR/Pictures
      if [ $? -ne 0 ]; then ko ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/Pictures
    fi
    cp $CWD/../wallpapers/* /home/$UTILISATEUR/Pictures/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/Pictures
    if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



# Panel Configuration
echo -e ":: Deactivation of Kpanel for users... \c"
sleep $DELAY
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cp $CWD/../config/plasma/* /home/$UTILISATEUR/.config/.
    if [ $? -ne 0 ]; then ko ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/plasma*
    if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



echo

exit 0
