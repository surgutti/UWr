#!/usr/bin/env bash


truncate -s 1G disk.img
du -h disk.img
ls -lh disk.img

sudo cryptsetup open --type=plain --key-file=/dev/urandom disk.img tmpdisk
sudo dd if=/dev/zero of=/dev/mapper/tmpdisk bs=1M oflag=direct conv=fsync status=progress
sudo cryptsetup close tmpdisk

dd if=/dev/urandom of=disk.img bs=1M count=1024 oflag=direct conv=fsync status=progress


: '
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 2.7127 s, 396 MB/s
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 5.94022 s, 181 MB/s

Przyspieszenie x2.18
'

du -h disk.img
sudo mkfs.ext2 -m 0 -L jfizo-rozw disk.img
du -h disk.img

: '
ext2 deklaruje niepoużywane bloki, jako do użytku systemu operacyjnego. Losowe dane rezydują na dysku, natomiast nie są aktywnie używane przez system plików.
'

sudo dumpe2fs disk.img
