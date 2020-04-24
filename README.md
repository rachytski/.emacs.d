# .emacs.d

A single source of truth for all my personal emacs settings.

For the ELPA package management use Emacs with version >=24. Some other packages (like irony) require more recent Emacs versions as they depend on some bugfixes. The lowest workable version for the configuration in this repo is 24.5.

init.el includes platform.el file which is not under VC as it contains platform and system specific settings. There is a platform.example.el file which can be used as a starting point. Settings there should be self explanatory.

For a snapshot of packages in a well known state use personal-elpa repo (git@github.com:rachytski/elpa-personal)
