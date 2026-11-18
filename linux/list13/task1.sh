#/usr/bin/env bash

debootstrap sid ./target http://deb.debian.org/debian/
unshare -imnpuf --mount-proc chroot ./target /bin/bash
mount -t proc proc /proc
ps -ef
mount
ip link

lsns # znajdujemy pid namespace'u
nsenter -t 22472 -a -r --wd=/home/surgutti/studia/linux/list13/target/ /bin/bash
