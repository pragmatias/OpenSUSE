#!/bin/bash
#
# Install of TrueType proprietary fonts

. functions_install_TW.sh

echo 


# Installer les polices Microsoft
  echo -e ":: Install of Microsoft TrueType fonts... \c"
if [ ! -d /usr/share/fonts/truetype/microsoft ]; then
  cp ../config/fonts/webcore-fonts-3.0.tar.gz /tmp/. >> $LOG 2>&1
  cp ../config/fonts/symbol.gz /tmp/. >> $LOG 2>&1
  pushd /tmp >> $LOG 2>&1
  rm -rf /usr/share/fonts/truetype/microsoft
  rm -rf /usr/share/fonts/truetype/msttcorefonts
 
  mkdir /usr/share/fonts/truetype/microsoft
  if [ $? -ne 0 ]; then ko ; fi
  tar xvf webcore-fonts-3.0.tar.gz >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  pushd webcore-fonts >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  # La police Cambria est un fichier TTC. Si FontForge est disponible, on
  # l'utilise pour le transformer en deux fichiers TTF.
  if type fontforge > /dev/null 2>&1; then
    fontforge -lang=ff -c 'Open("vista/CAMBRIA.TTC(Cambria)"); \
      Generate("vista/CAMBRIA.TTF");Close();Open("vista/CAMBRIA.TTC(Cambria Math)"); \
      Generate("vista/CAMBRIA-MATH.TTF");Close();' >> $LOG 2>&1
    if [ $? -ne 0 ]; then ko ; fi
    rm vista/CAMBRIA.TTC
  fi
  cp fonts/* /usr/share/fonts/truetype/microsoft/
  if [ $? -ne 0 ]; then ko ; fi
  cp vista/* /usr/share/fonts/truetype/microsoft/
  if [ $? -ne 0 ]; then ko ; fi
  popd >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  # Remplacer la police symbol.ttf par une version patchée
  # https://bugs.winehq.org/show_bug.cgi?id=24099
  gunzip -c symbol.gz > /usr/share/fonts/truetype/microsoft/symbol.ttf
  if [ $? -ne 0 ]; then ko ; fi
  popd >> $LOG 2>&1
  fc-cache -f -v >> $LOG 2>&1
  if [ $? -eq 0 ]; then ok ; else ko ; fi
else
  echo -e "[already exist]"
fi

# Installer les polices Apple
echo -e ":: Install of Apple TrueType fonts... \c"
if [ ! -d /usr/share/fonts/apple-fonts ]; then
  cp ../config/fonts/FontApple.tar.xz /tmp/. >> $LOG 2>&1
  cd /tmp
  rm -rf /usr/share/fonts/apple-fonts

  mkdir /usr/share/fonts/apple-fonts
  if [ $? -ne 0 ]; then ko ; fi
  tar xvf FontApple.tar.xz >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  mv Lucida*.ttf Monaco.ttf /usr/share/fonts/apple-fonts/
  if [ $? -ne 0 ]; then ko ; fi
  fc-cache -f -v >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  rm -f FontApple.tar.xz
  if [ $? -ne 0 ]; then ko ; fi
  cd - >> $LOG 2>&1
  if [ $? -eq 0 ]; then ok ; else ko ; fi
else
  echo -e "[already exist]"
fi

# Installer la police Eurostile
echo -e ":: Install of Eurostile TrueType fonts... \c"
if [ ! -d /usr/share/fonts/eurostile ]; then
  cp ../config/fonts/Eurostile.zip /tmp/. >> $LOG 2>&1
  cd /tmp
  rm -rf /usr/share/fonts/eurostile

  unzip Eurostile.zip -d /usr/share/fonts/ >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  mv /usr/share/fonts/Eurostile /usr/share/fonts/eurostile
  if [ $? -ne 0 ]; then ko ; fi
  fc-cache -f -v >> $LOG 2>&1
  if [ $? -ne 0 ]; then ko ; fi
  rm -f Eurostile.zip
  if [ $? -ne 0 ]; then ko ; fi
  cd - >> $LOG 2>&1
  if [ $? -eq 0 ]; then ok ; else ko ; fi
else
  echo -e "[already exist]"
fi

echo

exit 0
