export PS1="\W \u_ \[$(tput sgr0)\]"

alias tv='cd ~/Dropbox/MBP_local/tidal && tidalvim'
alias au='open -a audiomulch'
alias dl='youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
alias fzf='fzf --color bw'
alias F='ls | fzf --preview="head -n 10 {}"'
alias tw=t
alias t=task
alias m=mutt
alias wee=weechat
alias we='finger stockholm@graph.no'
alias vim=nvim
alias tw=rainbowstream
alias br=brightness
alias ..='cd ..'
alias sc=~/bin/sc-start
alias c="gcalcli agenda"

export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

export PATH=$HOME/bin:$HOME/.npm-global/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash