#!/usr/bin/env bash

# edit ~/.config/firejail/firefox.profile
# add `blacklist ${HOME}/.ssh`

firejail --net=none libreoffice
# add `net none` to ~/.config/firejail/libreoffice.profile
