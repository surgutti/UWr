#!/usr/bin/env bash

sudo adduser jantest
sudo usermod -G cdrom,audio,video,render,bluetooth,netdev,plugdev jantest
sudo visudo #jantest ALL=(root) NOPASSWD: /usr/sbin/ip
sudo groupadd projekt
sudo usermod -aG projekt jantest
sudo usermod -aG projekt surgutti
sudo chown :projekt opis.txt
chmod 660 opis.txt # wlasciciel rw, grupa: rw, inni: brak 
sudo visudo #jantest ALL=(surgutti) NOPASSWD: /usr/bin/whoami
sudo visudo #jantest ALL=(root) NOPASSWD: /usr/bin/chfn jantest
sudo deluser --remove-home jantest
sudo delgroup projekt
