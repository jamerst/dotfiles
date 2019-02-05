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

# NEMO
echo $'\nConfiguring nemo'
mklnk $wd/nemo/nemo $HOME/.local/share/
mklnk $wd/nemo/Templates $HOME/

# XSESSION
echo $'\nConfiguring xsession'
mklnk $wd/xsession/xsessionrc $HOME/.xsessionrc

# ZSH
echo $'\nConfiguring ZSH'
tar -xf zsh/oh-my-zsh.tar.gz -C zsh
if [ $? -eq 0 ]; then
    echo "ZSH archive successfully extracted"

    mklnk $wd/zsh/zshrc $HOME/.zshrc

    # set oh-my-zsh install folder variable in zshrc directly to folder - don't need to symlink
    sed -i "s|  export ZSH=.*|  export ZSH=$wd/zsh/oh-my-zsh|" $wd/zsh/oh-my-zsh/zshrc

    if [ $? -eq 0 ]; then
        echo "oh-my-zsh install path variable successfully set"
    else
        echo "Failed to set oh-my-zsh install path variable"
    fi
else
    echo "Failed to extract ZSH archive"
fi