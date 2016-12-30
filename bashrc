#!/bin/bash
# Amazing .bashrc for Debian
# Based heavily on the Ubuntu default .bashrc
#
# # ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# Thanks to Julien Ricard for his great website
#   http://bashrcgenerator.com/
#
# <==========================================================================>
#
# CONFIGURATION
# <=======================>
# external files

################################################################################
#   Options                                                                    #
################################################################################

export PAGER=less
export EDITOR=vim

force_color_prompt=yes
run_tmux=no
use_globstar=no


################################################################################
#   Configure Things                                                           #
################################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# General ---------------------

# Run tmux in every terminal
[[ "$run_tmux" == "yes" ]] && [[ "$TERM" != "screen-256color" ]] && exec tmux

# Keep LINES and COLUMNS up to date
shopt -s checkwinsize

# "**" used in a pathname expansion match all files and zero or more directories
# and subdirectories.
[[ "$use_globstar" == "yes" ]] && shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# History ------------------------------

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# Color Prompt -------------------------

color_prompt_string () {
	# Show Time
	PS1+='\[\e[00;32m\][\[\e[0m\]'
	PS1+='\[\e[00;38m\]$(date +%H:%M:%S)\[\e[0m\]'
	PS1+='\[\e[00;32m\]]\[\e[0m\]'

	# user@host(short)
	PS1+='\[\e[00;38m\] \[\e[0m\]'
	PS1+='\[\e[00;33m\]\u\[\e[0m'
	PS1+='\]\[\e[01;01;38m\]@\[\e[0m\]'
	PS1+='\[\e[00;32m\]\H\[\e[0m\]'

	# Curent Directory (basename)
	PS1+='\[\e[01;38m\]:\[\e[0m\]'
	PS1+='\[\e[00;36m\]\W\[\e[0m\]'

	# $ or #
	PS1+='\[\e[01;38m\]\\$ \[\e[0m\]'

	echo "$PS1"
}

nocolor_prompt_string () {
	# Show Time
	PS1+='['
	PS1+='`date +%H:%M:%S`'
	PS1+=']'

	# user@host(short)
	PS1+=' '
	PS1+='\u'
	PS1+='@'
	PS1+='\H'

	# Curent Directory (basename)
	PS1+=':'
	PS1+='\W'

	# $ or #
	PS1+='\$ '

	echo "PS1"
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color|screen-256color)
		color_prompt=yes;;
esac

if [ ! "$force_color_prompt" == "yes" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
    else
		color_prompt=
    fi
else
	color_prompt=yes
fi

# Set PS1
PS1=""
if [ "$color_prompt" = yes ]; then
	PS1=$(color_prompt_string)
else
	PS1=$(nocolor_prompt_string)
fi

case "$TERM" in
xterm*|rxvt*)
	# If this is an xterm set the title to user@host:dir
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Set color PS2
if [ "$color_prompt" = yes ]; then
	PS2="\e[01;01;32m...> \e[0m"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

unset color_prompt force_color_prompt


# Tab Completion -----------------------
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


################################################################################
#   Aliases                                                                    #
################################################################################

# Add dir(s) listed in ~/.bash_pathlist to PATH
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# some more aliases
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias lal='la -lhaF'
alias time='/usr/bin/time'
alias please='sudo $(fc -ln -1)'


################################################################################
#   Path                                                                       #
################################################################################

# .bash_pathlist
# to use, list directories to include in the PATH variable
# one directory per line
if [ -f "$HOME/.bash_pathlist" ]; then
	PATH=`cat "$HOME/.bash_pathlist" | \
	  sed 's/#.*$//' | \
	  grep -v "^[[:space:]]*$"| \
	  tr '\n' ':'`$PATH
fi
export PATH

