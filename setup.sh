#!/bin/sh
cd `dirname $0`
now=`date '+%Y%m%d%H%M%S'`
mkdir "$PWD/backups/$now"
for dotfile in .?*; do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] ; then
        if [ -e "$HOME/$dotfile" ]; then
            mv "$HOME/$dotfile" "$PWD/backups/$now"
        fi
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

# $B%5%V%b%8%e!<%k$r%$%s%9%H!<%k(B
git submodule update --init

# rbenv$B$G(Bruby-build$B$,F0:n$9$k$h$&:Y9)(B
if [ -e .rbenv/plugins ]; then
    rm .rbenv/plugins
fi
ln -s "$PWD/.rbenv_plugins" .rbenv/plugins

# vim$B%W%i%0%$%s$r%$%s%9%H!<%k(B
vim +NeoBundleInstall +q
