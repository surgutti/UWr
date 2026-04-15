#!/usr/bin/env bash

sudo useradd user13
sudo useradd user42
sudo passwd user13 #1234
sudo passwd user42 #4321

# Ctrl + Alt + Fx przełącza na x-ty VT

sudo mkdir -p /etc/systemd/system/getty@tty8.service.d
sudo tee /etc/systemd/system/getty@tty8.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin user13 --noclear tty8 alacrity
EOF

sudo mkdir -p /etc/systemd/system/getty@tty9.service.d
sudo tee /etc/systemd/system/getty@tty9.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin user42 --noclear tty9 alacrity
EOF

sudo systemctl daemon-reload
sudo systemctl enable getty@tty8.service getty@tty9.service
sudo systemctl restart getty@tty8.service getty@tty9.service

sudo reboot

systemctl status getty@tty8.service getty@tty9.service
fgconsole
who
