#!/usr/bin/env bash

xz -df 2026-04-21-raspios-trixie-armhf.img
mount -o loop,offset=8388608 ./2026-04-21-raspios-trixie-armhf.img /mnt
cp /mnt/bcm2710-rpi-3-b.dtb rpi

echo "1234" | openssl passwd -6 -stdin
# dodaj do /mnt/userconf user:password

qemu-system-aarch64 -machine help | grep 3B

qemu-img resize ./2026-04-21-raspios-trixie-armhf.img 8589934592

# kernel8.img is for 64 bit

qemu-system-arm \
-machine raspi2b \
-kernel ./rpi/kernel7.img \
-dtb ./rpi/bcm2710-rpi-2-b.dtb \
-sd ./2026-04-21-raspios-trixie-armhf.img \
-append "rw earlyprintk loglevel=8 console=ttyAMA0 root=/dev/mmcblk0p2 rootwait" \
-serial stdio

qemu-system-arm \
  -M raspi2b \
  -kernel ./rpi/kernel7.img \
  -dtb ./rpi/bcm2709-rpi-2-b.dtb \
  -drive file=./2026-04-21-raspios-trixie-armhf.img,format=raw,if=sd \
  -append "rw loglevel=8 console=ttyAMA0,115200 root=/dev/mmcblk0p2 rootwait" \
  -serial stdio \
  -display none

qemu-system-arm \
  -M raspi2b \
  -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2" \
  -cpu arm1176 \
  -dtb ./rpi/bcm2709-rpi-2-b.dtb \
  -sd ./2026-04-21-raspios-trixie-armhf.img \
  -kernel ./rpi/kernel7.img \
  -m 1G \
  -smp 4 \
  -serial stdio \
;


qemu-system-arm \
    -M raspi2b \
    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2" \
    -cpu arm1176 \
    -dtb bcm2709-rpi-2-b.dtb \
    -sd 2026-04-21-raspios-trixie-armhf.img \
    -kernel kernel7.img \
    -m 1G \
    -smp 4 \
    -serial stdio \
;
