#!/usr/bin/env bash

sudo apt install openbox xinit

sudo -u user13 -H sh -lc 'cat > ~/.xsession << "EOF"
exec openbox-session
EOF'
