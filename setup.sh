#!/bin/sh

cd `dirname $0`
CURRENT_DIR=$PWD
WORKING_DIR=$CURRENT_DIR/tmp

now=`date '+%Y%m%d%H%M%S'`
mkdir "$CURRENT_DIR/backups/$now"
for dotfile in .?*; do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ]; then
        if [ -e "$HOME/$dotfile" ]; then
            mv "$HOME/$dotfile" "$CURRENT_DIR/backups/$now"
        fi
        ln -Fis "$CURRENT_DIR/$dotfile" $HOME
    fi
done

# $B%5%V%b%8%e!<%k$r%$%s%9%H!<%k(B
git submodule update --init

# rbenv$B$G(Bruby-build$B$,F0:n$9$k$h$&:Y9)(B
if [ -e $CURRENT_DIR/.rbenv/plugins ]; then
    rm $CURRENT_DIR/.rbenv/plugins
fi
ln -s "$CURRENT_DIR/.rbenv_plugins" $CURRENT_DIR/.rbenv/plugins

# vim$B%W%i%0%$%s$r%$%s%9%H!<%k(B
vim +NeoBundleInstall +q

# git-flow$B$r%$%s%9%H!<%k(B
pushd $WORKING_DIR > /dev/null
wget --no-check-certificate -q -O - https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | INSTALL_PREFIX=$CURRENT_DIR/.bin bash -s install
popd > /dev/null
