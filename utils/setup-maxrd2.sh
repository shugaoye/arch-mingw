#!/bin/bash

cat >>/etc/pacman.conf <<EOF
[maxrd2]
SigLevel = Optional TrustAll
EOF
echo 'Server = https://github.com/maxrd2/arch-repo/releases/download/continuous' >>/etc/pacman.conf