#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd "${SCRIPT_DIR}"

# install apt deps
sudo apt update
APT_DEPS=$(cat apt.txt | tr "\n" " ")
sudo apt install -y ${APT_DEPS}

# install python deps
pip3 install -r pip.txt

# git alias
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.tree "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

# git configs
git config --global core.editor "vim"
git config --global core.pager "${HOME}/projects/diff-so-fancy/diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "${HOME}/projects/diff-so-fancy/diff-so-fancy --patch"

# tmux config
ln -s .tmux.conf ~/.tmux.conf

# repositories
if ! [ -d "${HOME}/projects/diff-so-fancy" ]; then
    mkdir -p "${HOME}/projects"
    git clone git@github.com:so-fancy/diff-so-fancy.git "${HOME}/projects/diff-so-fancy" --depth=1
fi

# bash-git-prompt source
if [ -d "${HOME}/bash-git-prompt" ]; then
    git clone git@github.com:magicmonty/bash-git-prompt.git "${HOME}/projects/bash-git-prompt" --depth=1
fi

# install alias
#TODO check if alias is already installed
echo "
# source my environment
source "${SCRIPT_DIR}/bashrc_extensions.sh"
" >> ~/.bashrc

echo "\
    Please source your ~/.bashrc:
$ source ~/.bashrc"

# SCRIPT_DIR
popd > /dev/null
