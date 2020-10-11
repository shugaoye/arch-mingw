# arch-mingw
Docker image for `MinGW-w64 build environment` based on [Arch Linux][4]. The image provides simple cross-compilation environment for windows 32/64bit builds.

This script was inspired by [maxrd2/arch-mingw][5]

## Building docker image manually
You can pull latest docker image with:
```bash
sudo docker pull shugaoye/arch-mingw
```

If you prefer to build it on your machine:
```bash
git clone https://github.com/shugaoye/docker-arch-mingw.git && cd docker-arch-mingw
sudo docker build -t shugaoye/arch-mingw -f Dockerfile .
```

## Usage
Start the docker container (replace `some-local-path` with dir to mount as docker home):
```bash
.run_image.sh
```

Compile your application:
```bash
git clone 'https://github.com/maxrd2/DivvyDroid.git'
mkdir DivvyDroid/build
sudo docker run -v DivvyDroid:/home/devel --rm -it shugaoye/docker-arch-mingw /bin/bash -c "\
	cd build && \
	i686-w64-mingw32-cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr .. && \
	make -j\$(nproc) nsis \
	"
ls -l build # windows binaries
```
cmake, configure, etc commands should be prefixed by i686/x86_64 for 32/64bit builds e.g. `i686-w64-mingw32-cmake`, `x86_64-w64-mingw32-configure`

## Build a MINGW package
```bash
git clone https://github.com/msys2/MINGW-packages.git
cd MINGW-packages/mingw-w64-argon2/
makepkg-mingw
```

## Dependencies
Extra/missing dependencies can be installed from [AUR][1]
```bash
pacaur -S mingw-w64-rapidjson
```
If mingw- version of the needed libarary is not available in AUR, you can add it yourself. The process is really straightforward. You would need to write a [PKBUILD file][2], which is as intuitive as it can get, see [mingw-w64-rapidjson][3], for example.

[1]: https://aur.archlinux.org/packages/?K=mingw-w64
[2]: https://wiki.archlinux.org/index.php/creating_packages
[3]: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mingw-w64-rapidjson
[4]: https://github.com/archlinux/archlinux-docker
[5]: https://github.com/maxrd2/arch-mingw
