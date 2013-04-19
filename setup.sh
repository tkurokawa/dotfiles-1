#!/bin/bash
ORIGIN=$(pwd)

DOT_FILES=(
    .zsh .zshrc .zshrc.alias
    .zshrc.linux .zshrc.osx .ctags
    .emacs.el .gdbinit .gemrc .gitconfig
    .gitignore .inputrc .irbrc .sbtconfig
    .screenrc .vimrc .vrapperrc
    import.scala .tmux.conf .tmux-powerlinerc
    .dir_colors .rdebugrc )

for file in ${DOT_FILES[@]}
do
    if [ -e $HOME/$file ]; then
        echo $HOME/$file exist. backup file $HOME/$file~ is created.
    fi
    ln -sb $HOME/dotfiles/$file $HOME/$file
done

mkdir $HOME/.tmux
cd $HOME/.tmux
git clone git@github.com:erikw/tmux-powerline.git
ln -sb $HOME/dotfiles/.tmux/tmux-powerline/themes/mytheme.sh $HOME/.tmux/tmux-powerline/themes/mytheme.sh
type cmake >/dev/null 2>&1
if [ "$?" -eq 0 ]; then
    git clone git@github.com:thewtex/tmux-mem-cpu-load.git
    ln -sb $HOME/dotfiles/.tmux/tmux-mem-cpu-load/tmux-mem-cpu-load.cpp $HOME/.tmux/tmux-mem-cpu-load/tmux-mem-cpu-load.cpp
    cd $HOME/.tmux/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
else
    echo "plz install cmake to display used-mem on tmux"
fi

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone git@github.com:Shougo/neobundle.vim.git

cd ${ORIGIN}
vim -c "NeoBundleInstall" -c qa
