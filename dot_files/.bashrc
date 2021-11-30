#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export MOZ_ENABLE_WAYLAND=1

alias su='su -l'
alias mc='mc -bd'
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
