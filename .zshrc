# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Options
setopt autocd extendedglob # Don't need "cd" to cd
setopt HIST_IGNORE_DUPS # Ignore duplicates only if directly after one another
setopt PROMPT_SUBST # Turn on command substitution in prompt

# Prompt
# Backup: PROMPT='%B%n@%M [%F{226}%T%f]'$'\n''[%2~] %F{2}$(git_branch)%f%b'
PROMPT='%B%F{179}%n@%M%f in %F{9}%2~%f $(git_branch 2 -v)at %F{67}%T%f'$'\n''→%b '

# Vim keybind stuff
bindkey -v
bindkey "^[[3~" delete-char
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^?" backward-delete-char

# Something?
zstyle :compinstall filename '/home/daniel/.zshrc'

# Tab completion (incl. exercism)
export fpath=(~/.config/exercism $fpath)
# Case insensitive tab completion from both "ends" of the word (so "bar" can autocomplete to "foobar").
# Tries to complete the word as typed first, then if it doesn't find a match, tries to ignore case.
# Thanks to https://stackoverflow.com/questions/24226685/have-zsh-return-case-insensitive-auto-complete-matches-but-prefer-exact-matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
_comp_options+=(globdots) # Include hidden files

# --- Aliases ---
alias p="sudo pacman"
alias bat="bat -p --paging=never"
alias cl="clear"
alias cds='cd `find ~ -type d | grep -v "\.git" | fzf`'
alias here='srcfile=$(find ~ -type f | grep -v "\.git" | fzf --preview "bat --style=numbers --color=always --line-range :500 {}") && [ $srcfile ] && mv $srcfile .'
alias hist='cat ~/.histfile | fzf'
alias vimf='vim $(fzf --preview "bat --style=numbers --color=always --line-range :500 {}")'
alias up='cd ..'
alias vpn='cd ~/Documents/kth/year-4/en2720/ && sudo bash vpn-connect.sh --disconnect && sleep 1 && sudo bash vpn-connect.sh'
# Git
alias gs="git status"
alias gl="git log --oneline"
alias up='cd ..'
# Colour
alias ls="ls -ha --color=auto --group-directories-first"
alias grep="grep --color=auto"
# Other
alias passgen="< /dev/urandom tr -dc '!?#*-_=()/&%'A-Za-z0-9 | head -c 16; echo"

# Environment
export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
# Jellyfin-webos manual installation
export LG_WEBOS_TV_SDK_HOME="$HOME/Documents/"
export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/CLI/bin"
# ... and then PATH
export PATH="$PATH:$HOME/scripts:$HOME/bin:$WEBOS_CLI_TV:$HOME/.local/bin"

git_branch() {
    # Backup: resp=$(git branch 2> /dev/null | grep \* | sed -e 's/* \(.*\)/(\1) /')
    resp=$(git branch 2> /dev/null | grep \* | sed -e 's/* \(.*\)/\1 /')
    [ $1 ] && col=$1 || col=2
    col_resp="%F{$col}$resp%f"
    [ $resp ] && echo -n "on $col_resp" || echo -n "$col_resp"
}

mkdirc() {
    mkdir $1 && cd $1
}
export mkdirc

edit() {
    [ -z $1 ] && fname=$(fzf --preview "bat --style=numbers --color=always --line-range :500 {}") || fname=$1
    [ $fname ] && nvim $fname
}
export edit

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh





# Change cursor shape for different vi modes. (Stolen from Luke Smith)
# function zle-keymap-select {
  # if [[ ${KEYMAP} == vicmd ]] ||
     # [[ $1 = 'block' ]]; then
    # echo -ne '\e[2 q'
  # elif [[ ${KEYMAP} == main ]] ||
       # [[ ${KEYMAP} == viins ]] ||
       # [[ ${KEYMAP} = '' ]] ||
       # [[ $1 = 'beam' ]]; then
    # echo -ne '\e[5 q'
  # fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
    # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    # echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
