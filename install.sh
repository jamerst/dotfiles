#!/bin/bash

function mklnk {
    # if the file already exists but isn't a symlink, rename to backup
    if [ -f $2 ] && (! [ -h $2 ]); then
        echo "File already exists, renaming"
        dateString=$(date +%s)
        mv $2 "$2_old-$dateString"
    fi

    ln -sf $1 $2

    if [ $? -eq 0 ]; then
        echo "Link created: $2 -> $1"
    else
        echo "Failed to create link: $2 -> $1"
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
else
    echo "Failed to extract conky archive"
fi

# CSSCOMB
echo $'\nConfiguring csscomb'
mklnk $wd/csscomb/csscomb.json $HOME/.csscomb.json

# FIREFOX
echo $'\nConfiguring Firefox UserChrome'
profile="$(cd $HOME/.mozilla/firefox/*.default; pwd)" # find default profile directory
mklnk $wd/firefox/chrome $profile/chrome

# KITTY
echo $'\nConfiguring kitty'
mklnk $wd/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

# NEMO
echo $'\nConfiguring nemo'
mklnk $wd/nemo/local $HOME/.local/share/nemo
mklnk $wd/nemo/Templates $HOME/Templates

# ZSH
echo $'\nConfiguring ZSH'
tar -xf zsh/oh-my-zsh.tar.gz -C zsh
if [ $? -eq 0 ]; then
    echo "ZSH archive successfully extracted"
    mklnk $wd/zsh/oh-my-zsh $HOME/.oh-my-zsh
    mklnk $wd/zsh/oh-my-zsh/zshrc $HOME/.zshrc
    mklnk $wd/zsh/z $HOME/.z
else
    echo "Failed to extract ZSH archive"
fi