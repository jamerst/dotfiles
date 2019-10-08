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
wd="$(pwd)"

# CKB-NEXT
echo $'\nConfiguring ckb-next'
mklnk $wd/ckb-next/ckb-next.conf $HOME/.config/ckb-next/ckb-next.conf

# CONKY
echo $'\nConfiguring conky'
# extract archive - need to use an archive to preserve git repos inside
tar -xf conky/conky-modern.tar.gz -C conky
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
profile="$(cd $HOME/.mozilla/firefox/*.default; pwd)" # find default profile directory
mklnk $wd/firefox/chrome/ $profile/

# KITTY
echo $'\nConfiguring kitty'
mklnk $wd/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

# LATEX
echo $'\nConfiguring LaTeX'
mklnk $wd/latex $HOME/texmf/tex/
texhash

# NEMO
echo $'\nConfiguring nemo'
mklnk $wd/nemo/nemo $HOME/.local/share/
mklnk $wd/nemo/Templates $HOME/

# XSESSION
echo $'\nConfiguring xsession'
mklnk $wd/xsession/xsessionrc $HOME/.xsessionrc

# ZSH
echo $'\nConfiguring ZSH'
mklnk $wd/zsh/zshrc $HOME/.zshrc

# set directory for scripts directly to path - no need for symlink
sed -i "s|dotfilesZsh=.*|dotfilesZsh=$wd/zsh|" $wd/zsh/zshrc

if [ $? -eq 0 ]; then
    echo "ZSH path variable successfully set"
else
    echo "Failed to set ZSH path variable"
fi