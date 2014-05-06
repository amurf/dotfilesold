#!/bin/sh

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cp -r vim ~/.vim
cp -r git-completion ~/.git-completion
cp -r bashrc ~/.bashrc
cp -r tmux.conf ~/.tmux.conf
cp -r gitconfig ~/.gitconfig
cp -r vimrc ~/.vimrc

source ~/.bashrc
