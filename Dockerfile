# MingW64 + Qt5 for cross-compile builds to Windows
# https://github.com/shugaoye/docker-arch-mingw
# Based on ArchLinux image - https://github.com/archlinux/archlinux-docker

FROM shugaoye/arch-mingw:dev

LABEL maintainer="shugaoye@yahoo.com"

COPY utils/setup-maxrd2.sh /root/
RUN /root/setup-maxrd2.sh

RUN pacman -Sy --noconfirm --noprogressbar \
	mingw-w64-toolchain mingw-w64-cmake mingw-w64-configure mingw-w64-pkg-config \
	mingw-w64-qt5

RUN rm -rf \
	/usr/share/{doc,man}/* \
	/tmp/* \
	/var/{tmp,cache/pacman/pkg,lib/pacman/sync}/* \
	/home/devel/.cache

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