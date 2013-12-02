#!/bin/bash
while :
do
  read -p "update? y/n " yn
  if [ $yn = "n" -o $yn = "N" ]; then
    exit
  elif [ $yn = "y" -o $yn = "Y" ]; then
    break
  else
    continue
  fi
done

ORIGIN=$(pwd)

# tmuxinator
if [ -x `which mux` ]; then
    gem install tmuxinator
fi

# tmux-mem-cpu-load
if [ -d $HOME/.tmux/tmux-mem-cpu-load ]; then
    cd $HOME/.tmux/tmux-mem-cpu-load
    git reset --hard HEAD
    git pull --rebase origin master
    sed -i -e "s/ << ' ' << load_string( use_colors )//" $HOME/.tmux/tmux-mem-cpu-load/tmux-mem-cpu-load.cpp
    cmake .
    make
    sudo make install
fi

# tmux-powerline
if [ -d $HOME/.tmux/tmux-powerline ]; then
    cd $HOME/.tmux/tmux-powerline
    git pull --rebase origin master
fi

# vvm
if [ -x `which vvm-rb` ]; then
    gem install vvm-rb
else
    vvm update_itself
fi

# auto-fu
if [ -d $HOME/.zsh/auto-fu.zsh ]; then
    cd $HOME/.zsh/auto-fu.zsh
    git pull --rebase origin pu
fi

# powerline-shell
if [ -d $HOME/.zsh/powerline-shell ]; then
    cd $HOME/.zsh/powerline-shell
    git pull --rebase origin master
    ./install.py
fi

# rbenv
if [ -d $HOME/.rbenv ]; then
    cd $HOME/.rbenv
    git pull --rebase origin master
fi

# rbenv-ctags
if [ -d $HOME/.rbenv/plugins/rbenv-ctags ]; then
    cd $HOME/.rbenv/plugins/rbenv-ctags
    git pull --rebase origin master
fi

# rbenv-default-gems
if [ -d $HOME/.rbenv/plugins/rbenv-default-gems ]; then
    cd $HOME/.rbenv/plugins/rbenv-default-gems
    git pull --rebase origin master
fi

# ruby-build
if [ -d $HOME/.rbenv/plugins/ruby-build ]; then
    cd $HOME/.rbenv/plugins/ruby-build
    git pull --rebase origin master
fi

# vim plugins
if [ -x `which vim` ]; then
    vim +NeoBundleUpdate +qa
fi

cd ${ORIGIN}
exec $SHELL
