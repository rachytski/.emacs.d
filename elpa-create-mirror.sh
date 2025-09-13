#!/bin/sh
rm -Rv ~/.emacs.d.cache/elpa-cache
emacs --batch \
      -l ~/.emacs.d/setup-create-mirror.el \
      -l ~/.emacs.d/init.el \
      -l ~/.emacs.d/do-create-mirror.el
