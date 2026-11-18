#!/usr/bin/env bash

sudo fdisk /dev/sdb
sudo mkfs.fat -F32 /dev/sdb2
sudo cryptsetup luksFormat --type luks1 /dev/sdb3
sudo cryptsetup open /dev/sdb3 cryptusb

grub-mkfont -o terminus16x32.pf2 -s 32 -n Terminus16x32 TerminusTTF-4.46.0.ttf

tar -C memdisk -cvf memdisk.tar .

grub-mkimage -O x86_64-efi -p / -o bootx64.efi -c early-grub.cfg -m memdisk.tar memdisk tar normal configfile gfxterm font all_video cryptodisk luks gcry_rijndael gcry_sha256 pbkdf2 part_gpt fat ext2

sudo mkdir -p /mnt/efi
sudo mount /dev/sdb2 /mnt/efi
sudo mkdir -p /mnt/efi/EFI/boot
sudo cp bootx64.efi /mnt/efi/EFI/boot/bootx64.efi

sudo mkfs.ext2 /dev/mapper/cryptusb

sudo umount /mnt/efi
sudo mount /dev/mapper/cryptusb /mnt

sudo mkdir -p /mnt/grub/x86_64-efi
sudo mkdir -p /mnt/boot

sudo rsync -av --exclude=monolithic --exclude=kernel.img --exclude=config.h --exclude=fdt.lst /usr/lib/grub/x86_64-efi/ /mnt/grub/x86_64-efi/
