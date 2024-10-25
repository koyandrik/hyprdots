#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PROMPT='[%n@%m %1~]%# '

export PATH=$PATH:$HOME/.spicetify
fastfetch
