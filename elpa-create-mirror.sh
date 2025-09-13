#!/bin/sh
rm -Rv ~/.emacs.d.cache ~/.emacs.d/elpa-mirror/packages
emacs --batch \
      -l ~/.emacs.d/setup-create-mirror.el \
      -l ~/.emacs.d/init.el \
      -l ~/.emacs.d/do-create-mirror.el
