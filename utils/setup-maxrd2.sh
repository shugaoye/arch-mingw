#!/bin/bash

cat >>/etc/pacman.conf <<EOF
[maxrd2]
SigLevel = Optional TrustAll
Server = https://github.com/maxrd2/arch-repo/releases/download/continuous
[shugaoye]
SigLevel = Optional TrustAll
Server = https://github.com/shugaoye/MINGW-packages/releases/download/x86_64
EOF
#echo 'Server = https://github.com/maxrd2/arch-repo/releases/download/continuous' >>/etc/pacman.conf