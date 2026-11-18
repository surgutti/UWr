#!/usr/bin/env bash

sudo dd if=/dev/urandom of=mnt/plik1 bs=1M count=300 conv=fsync status=progress

: """
surgutti@ouroboros:~/studia/linux/list15/mnt$ sudo filefrag plik1
plik1: 8 extents found
surgutti@ouroboros:~/studia/linux/list15/mnt$ sudo filefrag -v plik1
Filesystem type is: ef53
Filesystem cylinder groups approximately 8
File size of plik1 is 314572800 (76800 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      15:       1024..      1039:     16:             merged
   1:       16..      63:        624..       671:     48:       1040: merged
   2:       64..     255:        704..       895:    192:        672: merged
   3:      256..     511:       1664..      1919:    256:        896: merged
   4:      512..    1023:       2048..      2559:    512:       1920: merged
   5:     1024..   30719:       3072..     32767:  29696:       2560: merged
   6:    30720..   61439:      34816..     65535:  30720:      32768: merged
   7:    61440..   76799:      67584..     82943:  15360:      65536: last,merged,eof
plik1: 8 extents found
surgutti@ouroboros:~/studia/linux/list15/mnt$ sudo e2freefrag
e2freefrag: missing device name.
usage: e2freefrag [-c chunksize in kb] [-h] device_name
surgutti@ouroboros:~/studia/linux/list15/mnt$ sync
surgutti@ouroboros:~/studia/linux/list15/mnt$ cd ..
surgutti@ouroboros:~/studia/linux/list15$ sudo umount mnt
surgutti@ouroboros:~/studia/linux/list15$ sudo e2freefrag disk.img
Device: disk.img
Blocksize: 4096 bytes
Total blocks: 262144
Free blocks: 180825 (69.0%)

Min. free extent: 64 KB
Max. free extent: 129016 KB
Avg. free extent: 51664 KB
Num. free extent: 14

HISTOGRAM OF FREE EXTENT SIZES:
Extent Size Range :  Free extents   Free Blocks  Percent
   64K...  128K-  :             1            16    0.01%
  128K...  256K-  :             1            32    0.02%
  256K...  512K-  :             1            75    0.04%
  512K... 1024K-  :             1           128    0.07%
    2M...    4M-  :             2          1136    0.63%
    4M...    8M-  :             2          3003    1.66%
   32M...   64M-  :             1         15360    8.49%
   64M...  128M-  :             5        161075   89.08%
surgutti@ouroboros:~/studia/linux/list15$
"""
