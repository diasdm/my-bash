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
git config --global alias.no-edit-ci "commit --amend --no-edit"  # quiet amend

# git configs
git config --global core.editor "vim"
git config --global core.pager "${SCRIPT_DIR}/submodules/diff-so-fancy/diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "${SCRIPT_DIR}/submodules/diff-so-fancy/diff-so-fancy --patch"

# submodules
git submodule update --init

# tmux tpm
if ! [ -d "${HOME}/.tmux/plugins/tpm" ]; then
    echo "Creating tmux tpm symlink"
    ln -s "${SCRIPT_DIR}/submodules/tpm" "${HOME}/.tmux/plugins/tpm"
fi

# tmux config
if ! [ -f "${HOME}/.tmux.conf" ]; then
    echo "Creating tmux config symlink"
    ln -s "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
fi

# motivate
pushd "${SCRIPT_DIR}/submodules/motivate/motivate" > /dev/null
sudo ./install.sh
popd > /dev/null

# install alias
if ! grep "${SCRIPT_DIR}/bashrc_extensions.sh" ~/.bashrc > /dev/null; then
    echo "
# source personal environment
source "${SCRIPT_DIR}/bashrc_extensions.sh"
    " >> ~/.bashrc

    echo "
Please source your ~/.bashrc:
    $ source ~/.bashrc"
fi

# SCRIPT_DIR
popd > /dev/null
