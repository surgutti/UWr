#!/usr/bin/env bash
set -e

IMG="disk.img"

truncate -s 1T $IMG 

sudo sgdisk -Z $IMG
sudo sgdisk -U=7C54FB1F-0CEE-497F-9557-BCE60937DEF6 $IMG

sudo sgdisk -a=1\
  -n=1:34:2047 \
  -t=1:21686148-6449-6E6F-744E-656564454649 \
  -c=1:"GNU Grub 2" \
  -u=1:CC053A2A-29B4-4D05-9E49-F2D4CD0C3000 \
  $IMG

sudo sgdisk -a=1\
  -n=2:2048:262143 \
  -t=2:C12A7328-F81F-11D2-BA4B-00A0C93EC93B \
  -c=2:"ESP" \
  -u=2:B7E80F66-60D8-41C8-AD03-F54810C0CE42 \
  $IMG

sudo sgdisk -a=1\
  -n=3:262144:2097151 \
  -t=3:0FC63DAF-8483-4772-8E79-3D69D8477DE4 \
  -c=3:"Linux /boot" \
  -u=3:81633C0B-0C11-4346-A2E5-5E7B46601BCB \
  $IMG

sudo sgdisk -a=1\
  -n=4:2097152:1065353215 \
  -t=4:CA7D7CCB-63ED-4C53-861C-1742536059CC \
  -c=4:"Linux rootfs"\
  -u=4:C3191E5B-D22B-4377-AF3E-C899A17E4CCA \
  $IMG

sudo sgdisk -a=1\
  -n=5:1065353216:1073741823 \
  -t=5:0657FD6D-A4AB-43C4-84E5-0933C84B4F4F \
  -c=5:"Linux & OpenBSD swap" \
  -u=5:B056DC21-CD09-408A-A009-C28DE1E33DEC \
  $IMG

sudo sgdisk -a=1\
  -n=6:1073741824:2147483614 \
  -t=6:824CC7A0-36A8-11E3-890A-952519AD3F61 \
  -c=6:"OpenBSD rootfs" \
  -u=6:A5A73AB0-E418-4405-8466-70636A7F35B0 \
  $IMG

python3 <<'PY'
# https://wiki.osdev.org/MBR_%28x86%29
# https://en.wikipedia.org/wiki/Master_boot_record

import struct

IMG = "disk.img"

def entry(start, end, typ, chs_start, chs_end, bootable=False):
  status = 0x80 if bootable else 0x00

  size = end - start + 1
  return struct.pack('<B3sB3sII', status, bytes(chs_start), typ, bytes(chs_end), start, size)

chs_1 = bytes([0,2,0])
chs_2 = bytes([254,63+(64+128),255])

mbr = bytearray(512)
mbr[440:444] = struct.pack('<I', 0x7C54FB1F)
mbr[446:462] = entry(1,          1073741823, 0xee, chs_1, chs_2)
mbr[462:478] = entry(1073741824, 2147483614, 0xa6, chs_2, chs_2)
mbr[478:494] = bytes(16)
mbr[494:510] = entry(2147483615, 2147483647, 0xee, chs_2, chs_2)
mbr[510:512] = struct.pack('<BB', 0x55, 0xAA)

with open(IMG, 'r+b') as f:
  f.seek(0)
  f.write(mbr)

PY

echo "--- GPT ---"
sudo sgdisk -p $IMG

echo "--- MBR ---"
sudo sgdisk -O $IMG
