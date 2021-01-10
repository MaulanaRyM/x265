#!/bin/bash

clear
pkg install ffmpeg figlet ruby toilet tree
gem install lolcat
echo "alias vc='cd ~/vc && sh vc.sh'" >> ~/.zshrc
echo "alias vc='cd ~/vc && sh vc.sh'" >> ~/../usr/etc/bash.bashrc

$SHELL
