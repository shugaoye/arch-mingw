#!/bin/bash

use_cache= #192.168.1.5 # set to pacserve ip

set -e
info() { echo -e "\e[1;39m$@\e[m"; }

info "Setting up pacman"
pacman -Sy --noconfirm --noprogressbar pacman-contrib
# select pacman mirrors
[[ -z "$use_cache" ]] && rm /etc/pacman.d/mirrorlist || echo 'Server = http://'$use_cache':15678/pacman/$repo/$arch' >/etc/pacman.d/mirrorlist
curl -s 'https://www.archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&use_mirror_status=on' \
	| sed 's|^#||;/^#/ d' | rankmirrors -n 6 - >>/etc/pacman.d/mirrorlist
# add mingw repos - https://github.com/maxrd2/arch-repo/
cat >>/etc/pacman.conf <<EOF
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF