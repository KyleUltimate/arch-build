#!/bin/bash

pkgname=$1

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ../
rm -rf paru

sudo --set-home -u builder paru -S --noconfirm --builddir=./ "$pkgname"
