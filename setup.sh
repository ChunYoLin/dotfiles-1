#!/bin/sh

cd `dirname $0`
CURRENT_DIR=$PWD
WORKING_DIR=$CURRENT_DIR/tmp

mkdir -p $WORKING_DIR

print() {
    printf "\033[1;32m$*\033[0;39m\n"
}

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

# サブモジュールをインストール
print 'Install git submodules...'
git submodule update --init

# rbenvでruby-buildが動作するよう細工
print 'Setting for rbenv...'
if [ -e $CURRENT_DIR/.rbenv/plugins ]; then
    rm $CURRENT_DIR/.rbenv/plugins
fi
ln -s "$CURRENT_DIR/.rbenv_plugins" $CURRENT_DIR/.rbenv/plugins

# vimプラグインをインストール
print 'Install NeoBundle for vim...'
vim +NeoBundleInstall +q

# git-flowをインストール
print 'Install git-flow...'
cd $WORKING_DIR > /dev/null
wget --no-check-certificate -q -O - https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | INSTALL_PREFIX=$CURRENT_DIR/.bin bash -s install
cd - > /dev/null

print 'Successed!'
