#!/bin/bash
#
# Install of fonts

. ../00_functions_install.sh
. 00_env.sh

# Installer les polices Microsoft
msg_log="Install of Microsoft TrueType fonts"
logMessage "-1" "${msg_log}..."
if [ ! -d /usr/share/fonts/truetype/microsoft ]; then
  cp ../../config/fonts/Proprio/webcore-fonts-3.0.tar.gz /tmp/. >> $LOG 2>&1
  cp ../../config/fonts/Proprio/symbol.gz /tmp/. >> $LOG 2>&1
  pushd /tmp >> $LOG 2>&1
  rm -rf /usr/share/fonts/truetype/microsoft
  rm -rf /usr/share/fonts/truetype/msttcorefonts
 
  mkdir /usr/share/fonts/truetype/microsoft
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  tar xvf webcore-fonts-3.0.tar.gz >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  pushd webcore-fonts >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  # La police Cambria est un fichier TTC. Si FontForge est disponible, on
  # l'utilise pour le transformer en deux fichiers TTF.
  if type fontforge > /dev/null 2>&1; then
    fontforge -lang=ff -c 'Open("vista/CAMBRIA.TTC(Cambria)"); \
      Generate("vista/CAMBRIA.TTF");Close();Open("vista/CAMBRIA.TTC(Cambria Math)"); \
      Generate("vista/CAMBRIA-MATH.TTF");Close();' >> $LOG 2>&1
    if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
    rm vista/CAMBRIA.TTC
  fi
  cp fonts/* /usr/share/fonts/truetype/microsoft/
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  cp vista/* /usr/share/fonts/truetype/microsoft/
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  popd >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  # Remplacer la police symbol.ttf par une version patchée
  # https://bugs.winehq.org/show_bug.cgi?id=24099
  gunzip -c symbol.gz > /usr/share/fonts/truetype/microsoft/symbol.ttf
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  popd >> $LOG 2>&1
  fc-cache -f -v >> $LOG 2>&1
  logMessage "$?" "${msg_log}"
else
  logMessage "-1" "${msg_log} [already exist]"
fi

# Installer les polices Apple
msg_log="Install of Apple TrueType fonts"
logMessage "-1" "${msg_log}..."
if [ ! -d /usr/share/fonts/apple-fonts ]; then
  cp ../../config/fonts/Proprio/FontApple.tar.xz /tmp/. >> $LOG 2>&1
  cd /tmp
  rm -rf /usr/share/fonts/apple-fonts

  mkdir /usr/share/fonts/apple-fonts
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  tar xvf FontApple.tar.xz >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  mv Lucida*.ttf Monaco.ttf /usr/share/fonts/apple-fonts/
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  fc-cache -f -v >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  rm -f FontApple.tar.xz
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  cd - >> $LOG 2>&1
  logMessage "$?" "${msg_log}"
else
  logMessage "-1" "${msg_log} [already exist]"
fi

# Installer la police Eurostile
msg_log="Install of Eurostile TrueType fonts"
logMessage "-1" "${msg_log}..."
if [ ! -d /usr/share/fonts/eurostile ]; then
  cp ../../config/fonts/Proprio/Eurostile.zip /tmp/. >> $LOG 2>&1
  cd /tmp
  rm -rf /usr/share/fonts/eurostile

  unzip Eurostile.zip -d /usr/share/fonts/ >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  mv /usr/share/fonts/Eurostile /usr/share/fonts/eurostile
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  fc-cache -f -v >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  rm -f Eurostile.zip
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  cd - >> $LOG 2>&1
  logMessage "$?" "${msg_log}"
else
  logMessage "-1" "${msg_log} [already exist]"
fi


# Installer les polices divers
for fic_font in `ls -1 ../../config/fonts | grep "\.zip$"`
do
  msg_log="Install of ${fic_font} fonts"
  cp ../../config/fonts/${fic_font}  /usr/share/fonts/${fic_font}
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  cd /usr/share/fonts/
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  unzip -o ${fic_font} >> $LOG 2>&1
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  rm -f ${fic_font}
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  cd - > /dev/null
  if [ $? -ne 0 ]; then logMessage "1" "${msg_log}" ; fi
  logMessage "0" "${msg_log}"
done



exit 0
