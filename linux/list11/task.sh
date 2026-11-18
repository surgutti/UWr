#!/usr/bin/env bash

truncate -s 2G pendrive.img

sudo parted -s pendrive.img --align cylinder -- \
  unit s \
  mklabel msdos \
  mkpart primary fat32 2048s 100%

sudo fdisk -l pendrive.img

hd pendrive.img
