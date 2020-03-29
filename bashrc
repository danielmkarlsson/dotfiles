export LC_ALL=en_US.UTF-8
export PS1="\W t36s_ \[$(tput sgr0)\]"

alias dl='youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
alias dl3='youtube-dl -x --audio-format=mp3 -o "~/Downloads/%(title)s.%(ext)s"' 
alias dlw='youtube-dl -x --audio-format=wav -o "~/Downloads/%(title)s.%(ext)s"' 
alias dl4='youtube-dl -f mp4 -o "~/Downloads/%(title)s.%(ext)s"'
alias fzf='fzf --color bw'
alias F='ls | fzf --preview="head -n 10 {}"'
alias t=task
alias wee=weechat
alias we='finger stockholm@graph.no'
alias vim=nvim
alias br=brightness
alias ..='cd ..'
alias c="gcalcli agenda"
alias l="ls -l"

export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PATH=$HOME/bin:$HOME/.npm-global/bin:$HOME/Library/Python/3.7/bin:$PATH

export PYTHONPATH=$(python -c "import site; print(site.USER_SITE)"):$PYTHONPATH
export PATH=$PATH:~/.local/bin

FZF_DEFAULT_OPTS='--color=bw'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /Users/danielmkarlsson/.ghcup/env
