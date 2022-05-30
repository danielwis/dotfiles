# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Options
setopt autocd extendedglob # Don't need "cd" to cd
setopt HIST_IGNORE_DUPS # Ignore duplicates only if directly after one another
setopt PROMPT_SUBST # Turn on command substitution in prompt

# Prompt
PROMPT='%B%n@%M [%F{226}%T%f]'$'\n''[%2~] %F{2}$(git_branch)%f%b'

# Vim keybind stuff
bindkey -v
bindkey "^[[3~" delete-char
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^?" backward-delete-char

# Something?
zstyle :compinstall filename '/home/daniel/.zshrc'

# Tab completion
autoload -Uz compinit
compinit
_comp_options+=(globdots) # Include hidden files

# --- Aliases ---
alias p="sudo pacman"
alias bat="bat -p --paging=never"
alias cl="clear"
alias cds='cd `find ~ -type d | fzf`'
alias vimf='vim $(fzf --preview "bat --style=numbers --color=always --line-range :500 {}")'
# Git
alias gs="git status"
alias gl="git log --oneline"
# Colour
alias ls="ls -ha --color=auto --group-directories-first"
alias grep="grep --color=auto"
# Other
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

# Environment
export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
export PATH="$PATH:$HOME/scripts"

git_branch() {
    git branch 2> /dev/null | grep \* | sed -e 's/* \(.*\)/(\1) /'
}

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
