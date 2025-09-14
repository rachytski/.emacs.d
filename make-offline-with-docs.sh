#!/bin/sh
./elpa-create-mirror.sh
tar -c -f .emacs.d.tar -v .projectile *.el *.sh *.md fonts elpa-mirror devdocs-browser

