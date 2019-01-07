#!/bin/bash
wd="$(pwd)"

# CKB-NEXT
ln -sfv $wd/ckb-next/ckb-next.conf $HOME/.config/ckb-next/ckb-next.conf

# CONKY
ln -sfv $wd/conky/conky-modern/conky-modern.conky $HOME/.conkyrc

# CSSCOMB
ln -sfv $wd/csscomb/csscomb.json $HOME/.csscomb.json

# FIREFOX
profile="$(cd $HOME/.mozilla/firefox/*.default; pwd)" # find default profile directory
ln -sfv $wd/firefox/chrome $profile/chrome

# KITTY
ln -sfv $wd/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

# NEMO
ln -sfv $wd/nemo/local $HOME/.local/share/nemo
ln -sfv $wd/nemo/Templates $HOME/Templates

# ZSH
ln -sfv $wd/zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -sfv $wd/zsh/oh-my-zsh/zshrc $HOME/.zshrc
ln -sfv $wd/zsh/z $HOME/.z