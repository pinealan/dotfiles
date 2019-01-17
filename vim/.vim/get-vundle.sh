#!/bin/bash

mkdir bundle
cd bundle
git clone https://github.com/VundleVim/Vundle.vim
vim +PluginInstall +qall
