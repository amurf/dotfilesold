#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

./brew.install

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -r vim ~/.vim
cp -r git-completion ~/.git-completion
cp -r bashrc ~/.bashrc
cp -r tmux.conf ~/.tmux.conf
cp -r gitconfig ~/.gitconfig
cp -r vimrc ~/.vimrc

source ~/.bashrc
