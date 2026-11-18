#!/usr/bin/env bash

wget https://ftp.gnu.org/gnu/gnu-keyring.gpg
wget https://ftp.gnu.org/gnu/hello/hello-2.12.tar.gz
wget https://ftp.gnu.org/gnu/hello/hello-2.12.tar.gz.sig

gpg --keyring ./gnu-keyring.gpg --verify hello-2.12.tar.gz.sig hello-2.12.tar.gz

tar -xvf hello-2.12.tar.gz

cd hello-2.12
./configure
make
#sudo make install
sudo checkinstall

# changes

diff -u src/hello.c.orig src/hello.c > hello-add-color.patch
diff -u doc/hello.texi.orig doc/hello.texi >> hello-add-color.patch

patch -p0 < hello-add-color.patch
