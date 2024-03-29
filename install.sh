#!/bin/bash

function mklnk {
    linkName=$2
    # if destination is a folder, set link name to be displayed
    if [ -d $1 ]; then
        linkName="$2$(basename $1)"
    fi

    # if the file already exists but isn't a symlink, rename to backup
    if [ -f $2 ] && (! [ -h $2 ]); then
        echo "File already exists, renaming"
        dateString=$(date +%s)
        mv $2 "$2_old-$dateString"
    fi

    if [ -d "$2$(basename $1)" ] && (! [ -h "$2$(basename $1)" ]); then
        echo "Folder already exists, renaming"
        dateString=$(date +%s)
        mv "$2$(basename $1)" "$2$(basename $1)_old-$dateString"
    fi

    ln -sf $1 $2

    if [ $? -eq 0 ]; then
        echo "Link created: $linkName -> $1"
    else
        echo "Failed to create link: $linkName -> $1"
    fi
}

# get the current working directory
wd="$(dirname "$(readlink -f $0)")"

# CONKY
echo $'\nConfiguring conky'
# extract archive - need to use an archive to preserve git repos inside
tar -xf $wd/conky/conky-modern.tar.gz -C $wd/conky
# only create if extracted successfully
if [ $? -eq 0 ]; then
    echo "Conky archive successfully extracted"
    mklnk $wd/conky/conky-modern/conky-modern.conky $HOME/.conkyrc
    mklnk $wd/conky/conky-modern $HOME/.conky/
else
    echo "Failed to extract conky archive"
fi

# CSSCOMB
echo $'\nConfiguring csscomb'
mklnk $wd/csscomb/csscomb.json $HOME/.csscomb.json

# FIREFOX
echo $'\nConfiguring Firefox UserChrome'
if [ `find $HOME/.mozilla/firefox -type d -name "*.default*" | wc -l` -gt 1 ] && [ ! -z `grep "Default=1" $HOME/.mozilla/firefox/profiles.ini` ] ; then
    profile=`grep -B 1 "Default=1" $HOME/.mozilla/firefox/profiles.ini | head -n 1 | cut -c6-` # find default profile directory if there is more than one with "default" in the name
    echo "profile=$profile"
else
    profile=$(basename `find $HOME/.mozilla/firefox -type d -name "*.default*" | head -n 1`)
    echo "profile=$profile"
fi

if [[ -z "$profile" ]]; then
    echo "Failed to find Firefox profile directory"
else
    mklnk $wd/firefox/chrome/ "$HOME/.mozilla/firefox/$profile/"
fi

# GNOME-TERMINAL
echo $'\nConfiguring gnome-terminal'
cat $wd/gnome-terminal/one-dark | dconf load /org/gnome/terminal/legacy/profiles:/
if [ $? -eq 0 ]; then
    echo "gnome-terminal settings successfully loaded"
else
    echo "Failed to load gnome-terminal settings"
fi

# LATEX
echo $'\nConfiguring LaTeX'
mklnk $wd/latex $HOME/texmf/tex/
texhash

# NEMO
echo $'\nConfiguring nemo'
mklnk $wd/nemo/nemo $HOME/.local/share/
mklnk $wd/nemo/Templates $HOME/

# OMNISHARP
echo $'\nConfiguring OmniSharp'
mklnk $wd/omnisharp/omnisharp.json $HOME/.omnisharp/omnisharp.json

# REDSHIFT
echo $'\nConfiguring redshift'
mklnk $wd/redshift/redshift.conf $HOME/.config/redshift.conf
mklnk $wd/redshift/hooks $HOME/.config/redshift/

# THEMES
echo $'\n Configuring Themes'
mklnk $wd/themes/Mint-Y-Dark-Aqua $HOME/.themes/

# ZSH
echo $'\nConfiguring ZSH'
mklnk $wd/zsh/zshrc $HOME/.zshrc

git clone --depth=1 https://github.com/mattmc3/antidote.git $wd/zsh/antidote
chmod u+x $wd/zsh/antidote/antidote.zsh

# set directory for scripts directly to path - no need for symlink
sed -i "s|dotfilesZsh=.*|dotfilesZsh=$wd/zsh|" $wd/zsh/zshrc
if [ $? -eq 0 ]; then
    echo "ZSH path variable successfully set"
else
    echo "Failed to set ZSH path variable"
fi

mklnk $wd/zsh/spaceshiprc.zsh $HOME/.spaceshiprc.zsh
