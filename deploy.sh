#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd "${SCRIPT_DIR}"

# install apt deps
sudo apt update
APT_DEPS=$(cat apt.txt | tr "\n" " ")
sudo apt install -y ${APT_DEPS}

# install pip deps
pip3 install -r pip.txt

# git alias
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.tree "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

# tmux config
ln -s .tmux.conf ~/.tmux.conf

# install alias
#TODO check if alias is already installed
echo "
# source my environment
source ${SCRIPT_DIR}/alias.sh
" >> ~/.bashrc

echo "\
    Please source your ~/.bashrc:
$ source ~/.bashrc"

# SCRIPT_DIR
popd > /dev/null

