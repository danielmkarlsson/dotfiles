export LC_ALL=en_US.UTF-8
export PS1="\W r23h_ \[$(tput sgr0)\]"

alias fzf='fzf --color bw'
alias F='ls | fzf --preview="head -n 10 {}"'
alias vim=nvim
alias ..='cd ..'
alias l="ls -l"

export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PATH=$HOME/bin:$HOME/.npm-global/bin:$HOME/Library/Python/3.7/bin:$PATH

export PYTHONPATH=$(python -c "import site; print(site.USER_SITE)"):$PYTHONPATH
export PATH=$PATH:~/.local/bin

FZF_DEFAULT_OPTS='--color=bw'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
