# MingW64 + Qt5 for cross-compile builds to Windows
# https://github.com/shugaoye/docker-arch-mingw
# Based on ArchLinux image - https://github.com/archlinux/archlinux-docker

FROM archlinux/base:latest

LABEL maintainer="shugaoye@yahoo.com"

COPY setup.sh /root/
RUN /root/setup.sh

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
ENTRYPOINT ["/root/docker_entrypoint.sh"]