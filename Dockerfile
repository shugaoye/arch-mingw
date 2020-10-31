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

RUN pacman -Sy --noconfirm --noprogressbar \
	mingw-w64-libgpg-error mingw-w64-sdl \
	mingw-w64-qrencode mingw-w64-libgcrypt mingw-w64-argon2 \
	mingw-w64-libsodium mingw-w64-readline asciidoctor

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
COPY patch/libargon2_patched.a /usr/x86_64-w64-mingw32/lib/
ENTRYPOINT ["/root/docker_entrypoint.sh"]