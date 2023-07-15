PROMPT='%1~ '

# allow bash-style comments
setopt interactivecomments

# exports
export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"
export MANPAGER='nvim +Man!'
export LC_ALL=en_US.UTF-8

alias vim=nvim
alias ..='cd ..'
alias l="ls -l"
alias dl='youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
alias dl3='youtube-dl -x --audio-format=mp3 -o "~/Downloads/%(title)s.%(ext)s"' 
alias dlw='youtube-dl -x --audio-format=wav -o "~/Downloads/%(title)s.%(ext)s"' 
alias dl4='youtube-dl -f mp4 -o "~/Downloads/%(title)s.%(ext)s"'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE
setopt no_list_ambiguous
autoload -Uz compinit && compinit
