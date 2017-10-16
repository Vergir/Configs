#!/bin/bash -e

CONFIGS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "APPLYING .inputrc ..."
if [ -f ~/.inputrc ]; 
then
	[ -h ~/.inputrc ] || echo "\$include ${CONFIGS_DIR}/.inputrc" > ~/.inputrc
else
	ln -sf ${CONFIGS_DIR}/.inputrc ~/.inputrc
fi

echo "APPLYING .bashrc ..."
if [ -f ~/.bashrc ]; 
then
	[ -h ~/.bashrc ] || echo "source ${CONFIGS_DIR}/.bashrc" > ~/.bashrc
else
	ln -sf ${CONFIGS_DIR}/.bashrc ~/.bashrc
fi

echo "APPLYING .vimrc ..."
if [ -f ~/.vimrc ]; 
then
	[ -h ~/.vimrc ] || echo "source ${CONFIGS_DIR}/.vimrc" > ~/.vimrc
else
	ln -sf ${CONFIGS_DIR}/.vimrc ~/.vimrc
fi

if [ -d ~/.vim ];
then
	echo "~/.vim ALREADY PRESENT. MERGE MANUALLY"
else
	echo "APPLYING ~/.vim"
	ln -sf ${CONFIGS_DIR}/.vim ~/.vim
fi

if [ -d ~/.fonts ];
then
	echo "~/.fonts ALREADY PRESENT. MERGE MANUALLY"
else
	echo "APPLYING ~/.fonts"
	ln -sf ${CONFIGS_DIR}/fonts ~/.fonts
fi

echo -n "WE XTERM? ... "
if [[ $TERM == *"xterm"* ]];
then
	echo "YES. APPLYING .Xresources"
	[ -f ~/.Xresources ] && mv ~/.Xresources ~/.Xresources.old
	ln -sf ${CONFIGS_DIR}/.Xresources ~/.Xresources
else
	echo "NO."
fi
 
echo -n "WE GIT? ... "
if ! [ -z "$(type -t git)" ];
then
	echo "YES. APPLYING .gitconfig"
	[ -f ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.old
	ln -sf ${CONFIGS_DIR}/.gitconfig ~/.gitconfig
else
	echo "NO."
fi

echo "FINISH"
