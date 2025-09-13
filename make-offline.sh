#!/bin/sh
./elpa-create-mirror.sh
tar -c -f .emacs.d.tar -v .projectile *.el *.sh *.md fonts elpa-mirror/elpa-mirror.el *.eld elpa-mirror/packages
