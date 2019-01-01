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
echo -e ":: Customization of the shell ZSH for root... \c"
sleep $DELAY
cat $CWD/../config/zsh/zshrc  > /root/.zshrc
if [ $? -eq 0 ]; then ok ; else ko ; fi


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
echo -e ":: Customization of the shell ZSH for users... \c"
sleep $DELAY
cat $CWD/../config/zsh/zshrc > /etc/skel/.zshrc
if [ $? -ne 0 ]; then ko ; fi
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cat $CWD/../config/zsh/zshrc  > /home/$UTILISATEUR/.zshrc
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.zshrc
	if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok


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
	if [ -e /home/$UTILISATEUR/.vim/bundle ]; then
		rm -rf /home/$UTILISATEUR/.vim/bundle
	fi
	git clone https://github.com/VundleVim/Vundle.vim.git /home/$UTILISATEUR/.vim/bundle/Vundle.vim >> $LOG 2>&1
	if [ $? -ne 0 ]; then ko ; fi
	chown -R $UTILISATEUR:users /home/$UTILISATEUR/.vim
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
    cat $CWD/../config/latte/users.layout.latte > /home/$UTILISATEUR/.config/latte/users.layout.latte
    if [ $? -ne 0 ]; then ko ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.config/latte/users.layout.latte
	if [ $? -ne 0 ]; then ko ; fi
  done
fi
ok



echo

exit 0
