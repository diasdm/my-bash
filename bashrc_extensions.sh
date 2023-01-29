# bash-git-prompt source
if [ -f "${HOME}/projects/bash-git-prompt/gitprompt.sh" ]; then
    export GIT_PROMPT_ONLY_IN_REPO=1
    source "${HOME}/projects/bash-git-prompt/gitprompt.sh"
    export GIT_PROMPT_THEME=Single_line_Ubuntu
fi

#alias
alias gti='git'
alias file-num='ls | wc -l'
alias venv-act='. .venv/bin/activate'
