#!/usr/bin/env bash

: '
e2fsprogs provides various utilities for disk management, debuging and testing.

Here are some provided commands (dpkg -L e2fsprogs):

chattr
lsattr

badblocks
debugfs
dumpe2fs
e2freefrag
e2fsck
e2image
e2scrub
e2scrub_all
e2undo
e4crypt
e4defrag
filefrag
mke2fs
mklost+found
resize2fs
tune2fs

e2tools are utilities for manipulating files in an ext2/ext4 firesystem. E2tools is a simple set of utilities to read, write, and manipulate files in an ext2/ext3 filesystem.
j

Provided commands:
e2cp
e2ln
e2ls
e2mkdir
e2mv
e2rm
e2tail

All commands are helpful for managing the ext filesystem without mounting it.

sleuthkit - a tools for forensics. Allows to examine the layout of disks and other media. Recover deleted files, get information stored in slack spaces, examine filesystems journal, see partitions layout on disks or images etc.
blkcalc
blkcat
blkls
blkstat
fcat
ffind
fiwalk
fls
fsstat
hfind
icat
ifind
ils
img_cat
img_stat
istat
jcat
jls
jpeg_extract
mactime
mmcat
mmls
mmstat
pstat
sigfind
sorter
srch_strings
tsk_comparedir
tsk_gettimes
tsk_imageinfo
tsk_loaddb
tsk_recover
usnjls

disktype - detection of content format of a disk or disk image. The purpose of disktype is toe detect the content format of a disk or disk image. It knows about common file systems, partition tables and boot codes. This software can be used for forensics analysis.

Commands:
disktype - for checking the type of a disk
'
