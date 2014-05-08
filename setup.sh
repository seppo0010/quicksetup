#!/usr/bin/env bash

sudo apt-get install -y vim zsh curl git-core

echo "export EDITOR=vim" >> ~/.zshrc
echo "set -o vi" >> ~/.zshrc

curl -L http://install.ohmyz.sh | sh

sudo chsh -s /bin/zsh `whoami`

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="tonotdo"/' ~/.zshrc

touch ~/.ssh/known_hosts
ssh-keyscan -t rsa,dsa github.com 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts
cat ~/.ssh/tmp_hosts >> ~/.ssh/known_hosts
rm ~/.ssh/tmp_hosts

git clone https://github.com/mariano/dot-vim ~/.vim

pushd ~/.vim
git submodule update --init
cd ..
ln -s .vim/.vimrc
popd

cat >> ~/.vimrc <<EOF
function! ThreeSpaces()
    set expandtab▸  ▸   " Treat TAB as spacesa
    set tabstop=3▸  ▸   " TAB is actually 3 spaces
    set shiftwidth=3▸   " Doing >> on a block whill shift it one tab (based on ts setting above)
    set softtabstop=3   " makes the spaces feel like real tabs
endfunction

function! TwoSpaces()
    set expandtab▸  ▸   " Treat TAB as spacesa
    set tabstop=2▸  ▸   " TAB is actually 2 spaces
    set shiftwidth=2▸   " Doing >> on a block whill shift it one tab (based on ts setting above)
    set softtabstop=2   " makes the spaces feel like real tabs
endfunction

:call ThreeSpaces()
EOF

unlink ~/.vim/bundle/jslint

git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st "status --short"
git config --global alias.br branch
git config --global core.excludesfile ~/.gitignore_global
git config --global alias.fix "commit --amend -C HEAD"

git config --global user.name "Sebastian Waisbrot"
git config --global user.email "seppo0010@gmail.com"

git config --global push.default simple

echo ".*.swp" > ~/.gitignore_global
