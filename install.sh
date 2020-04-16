#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

./brew.install

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -r vim ~/.vim
cp -r git-completion ~/.git-completion
cp -r bashrc ~/.bashrc
cp -r tmux.conf ~/.tmux.conf
cp -r gitconfig ~/.gitconfig
cp -r vimrc ~/.vimrc
cp -r inputrc ~/.inputrc

source ~/.bashrc
