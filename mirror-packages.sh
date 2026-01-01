#!/bin/sh
rm -Rv ~/.emacs.d/elpa-mirror/
emacs --batch \
      -l ~/.emacs.d/init.el \
      -l ~/.emacs.d/create-packages-mirror.el
