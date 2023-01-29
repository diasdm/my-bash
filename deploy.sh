#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd "${SCRIPT_DIR}" > /dev/null

# install apt deps
echo "Installing APT dependencies"
sudo apt update
APT_DEPS=$(cat "${SCRIPT_DIR}/apt.txt" | tr "\n" " ")
sudo apt install -y ${APT_DEPS}

# install python deps
pip3 install -r pip.txt

# git alias
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.tree "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
git config --global alias.qa "commit --amend --no-edit"  # quiet amend

# git configs
git config --global core.editor "vim"
git config --global core.pager "${HOME}/projects/diff-so-fancy/diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "${HOME}/projects/diff-so-fancy/diff-so-fancy --patch"

# tmux config
if [ -f "${HOME}/.tmux.conf" ]; then
    ln -s "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
fi

# repositories
if ! [ -d "${HOME}/projects/diff-so-fancy" ]; then
    mkdir -p "${HOME}/projects"
    git clone git@github.com:so-fancy/diff-so-fancy.git "${HOME}/projects/diff-so-fancy" --depth=1
fi

# bash-git-prompt source
if ! [ -d "${HOME}/projects/bash-git-prompt" ]; then
    git clone git@github.com:magicmonty/bash-git-prompt.git "${HOME}/projects/bash-git-prompt" --depth=1
fi

# install alias
if ! grep "${SCRIPT_DIR}/bashrc_extensions.sh" ~/.bashrc > /dev/null; then
    echo "
# source my environment
source "${SCRIPT_DIR}/bashrc_extensions.sh"
    " >> ~/.bashrc

    echo "
Please source your ~/.bashrc:
    $ source ~/.bashrc"
fi

# SCRIPT_DIR
popd > /dev/null
