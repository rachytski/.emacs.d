#!/bin/sh
./mirror-packages.sh
tar -c -f .emacs.d.tar -v .projectile *.el *.sh *.md fonts elpa-mirror
