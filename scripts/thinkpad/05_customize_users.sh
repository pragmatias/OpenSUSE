#!/bin/bash
#
# Customization of Desktop

. 00_functions_install.sh
. 00_env.sh

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
#    mkdir -p /home/$UTILISATEUR/.vim/autoload
#    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
#    cat $CWD/../config/vim/autoload/plug.vim > /home/$UTILISATEUR/.vim/autoload/plug.vim
#    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
#    chown $UTILISATEUR:users /home/$UTILISATEUR/.vim/autoload/plug.vim
#    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



# Personnalisation de Konsole pour les utilisateurs (colorscheme)
msg_log="Customization of Konsole for users"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.local/share/konsole ]; then
      mkdir /home/$UTILISATEUR/.local/share/konsole
      if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
      chown $UTILISATEUR:users /home/$UTILISATEUR/.local/share/konsole
    fi
    cp $CWD/../config/konsole/* /home/$UTILISATEUR/.local/share/konsole/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.local/share/konsole
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    cp $CWD/../config/konsolerc /home/$UTILISATEUR/.config/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/konsolerc
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



# Deactivate Kwallet
msg_log="Deactivate Kwallet subsystem for users"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    cp $CWD/../config/kwalletrc /home/$UTILISATEUR/.config/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/kwalletrc
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

    cp $CWD/../config/conky/start_conky_shortcut.sh /home/$UTILISATEUR/.config/conky/start_conky_shortcut.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    cp $CWD/../config/conky/start_conky_shortcut_alt.sh /home/$UTILISATEUR/.config/conky/start_conky_shortcut_alt.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chmod +x /home/$UTILISATEUR/.config/conky/start_conky_shortcut*.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown $UTILISATEUR:users /home/$UTILISATEUR/.config/conky/start_conky_shortcut*.sh
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  done
fi
logMessage "0" "${msg_log}"



# Personnalisation d'i3
msg_log="Customization of I3"
logMessage "-1" "${msg_log}..."
if [ ! -z "$(ls -A /home)" ]; then
  for UTILISATEUR in $(ls /home); do
    if [ ! -e /home/$UTILISATEUR/.config/i3 ]; then
        mkdir /home/$UTILISATEUR/.config/i3
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/i3
    fi
    cp $CWD/../config/i3/vm/config /home/$UTILISATEUR/.config/i3/config
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    cp $CWD/../config/i3/*.sh /home/$UTILISATEUR/.config/i3/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/i3
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi


    #polybar
    if [ ! -e /home/$UTILISATEUR/.config/polybar ]; then
        mkdir /home/$UTILISATEUR/.config/polybar
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/polybar
    fi
    cp $CWD/../config/polybar/vm/config /home/$UTILISATEUR/.config/polybar/config
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    cp $CWD/../config/polybar/*.sh /home/$UTILISATEUR/.config/polybar/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    cp $CWD/../config/polybar/*.env /home/$UTILISATEUR/.config/polybar/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/polybar
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi

    #i3lock
    if [ ! -e /home/$UTILISATEUR/.config/polybar/i3lock-fancy ]; then
        mkdir /home/$UTILISATEUR/.config/polybar/i3lock-fancy
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/polybar/i3lock-fancy
    fi
    cp $CWD/../config/polybar/i3lock-fancy/* /home/$UTILISATEUR/.config/polybar/i3lock-fancy/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/polybar/i3lock-fancy
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi


    #compton
#    if [ ! -e /home/$UTILISATEUR/.config/compton ]; then
#        mkdir /home/$UTILISATEUR/.config/compton
#        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
#        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/compton
#    fi
#    cp $CWD/../config/compton/compton.conf /home/$UTILISATEUR/.config/compton/compton.conf
#    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
#    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/compton
#    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi

    #dunst
    if [ ! -e /home/$UTILISATEUR/.config/dunst ]; then
        mkdir /home/$UTILISATEUR/.config/dunst
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/dunst
    fi
    cp $CWD/../config/dunst/* /home/$UTILISATEUR/.config/dunst/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/dunst
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi

    #ranger
    if [ ! -e /home/$UTILISATEUR/.config/ranger ]; then
        mkdir /home/$UTILISATEUR/.config/ranger
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/ranger
    fi
    cp $CWD/../config/ranger/* /home/$UTILISATEUR/.config/ranger/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/ranger
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi


    #rofi
    if [ ! -e /home/$UTILISATEUR/.config/rofi ]; then
        mkdir /home/$UTILISATEUR/.config/rofi
        if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
        chown $UTILISATEUR:users /home/$UTILISATEUR/.config/rofi
    fi
    cp $CWD/../config/rofi/* /home/$UTILISATEUR/.config/rofi/.
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config/rofi
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi

    
    #Xresources
    cp $CWD/../config/Xresources /home/$UTILISATEUR/.Xresources
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.Xresources
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi

  done
fi
logMessage "0" "${msg_log}"



exit 0
