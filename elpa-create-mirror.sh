#!/bin/sh
rm -Rv ~/.cache ~/.emacs.d/elpa-mirror
emacs --batch \
      -l ~/.emacs.d/setup-create-mirror.el \
      -l ~/.emacs.d/init.el \
      -l ~/.emacs.d/do-create-mirror.el
