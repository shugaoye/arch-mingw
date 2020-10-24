# MingW64 + Qt5 for cross-compile builds to Windows
# https://github.com/shugaoye/docker-arch-mingw
# Based on ArchLinux image - https://github.com/archlinux/archlinux-docker

FROM shugaoye/arch-mingw:base

LABEL maintainer="shugaoye@yahoo.com"

#RUN pacman -S --noconfirm --noprogressbar pacaur
RUN pacman -S --noconfirm --noprogressbar \
	sudo imagemagick make git binutils patch base-devel python2 python3 wget curl \
	expac yajl vim openssh rsync lzop unzip bash-completion ncdu jq

#USER devel
#ENV HOME=/home/devel
WORKDIR /home

ONBUILD USER root
ONBUILD WORKDIR /

COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
COPY utils/bashrc /root/bashrc
COPY utils/windeployqt /usr/local/bin/windeployqt
COPY utils/makepkg-mingw /usr/local/bin/makepkg-mingw
COPY utils/makepkg_mingw64.conf /etc/makepkg_mingw64.conf
#ENTRYPOINT ["/root/docker_entrypoint.sh"]
