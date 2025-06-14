SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# bash-git-prompt source
if [ -f "${SCRIPT_DIR}/submodules/bash-git-prompt/gitprompt.sh" ]; then
    export GIT_PROMPT_ONLY_IN_REPO=1
    source "${SCRIPT_DIR}/submodules/bash-git-prompt/gitprompt.sh"
    export GIT_PROMPT_THEME=Single_line_Ubuntu
fi

#alias
alias gti='git'
alias file-num='ls | wc -l'
alias venv-create='rm -rf .venv && python3 -m venv .venv && . .venv/bin/activate'
alias venv-act='. .venv/bin/activate'
alias venv-setup='pip install -r '
alias pra='pre-commit run -a'
