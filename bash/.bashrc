# Mostly imported from Gentoo.
# https://gitweb.gentoo.org/repo/gentoo.git/tree/app-shells/bash/files/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

PROMPT_COMMAND=__prompt_command_fishlike

__prompt_command_fishlike() {
	local exitCode="$?"
	local gitHash=$(git rev-parse HEAD 2>/dev/null|head -c8)
	local gitBranch=$(git symbolic-ref --short -q HEAD 2>/dev/null)
	local gitShow=$([ ! -z "${gitBranch}" ] && echo "${gitBranch}" || echo "${gitHash}")
	PS1=""

	local Reset='\[\e[0m\]'
	local Red='\[\e[0;31m\]'
	local BoldRed='\[\e[1;31m\]'
	local Green='\[\e[0;32m\]'

	PS1+="${Green}\u${Reset}@\h ${Green}\w${Reset}"
	if [ ! -z "${gitShow}" ]; then
		PS1+=" (${gitShow})"
	fi
	if [ $exitCode != 0 ]; then
		PS1+=" ${BoldRed}[${exitCode}]${Reset}"
	fi
	PS1+="> ${Reset}"
}

export CLICOLOR=1 # ls colors on macOS
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

set -o vi
export PROMPT_DIRTRIM=3
export EDITOR=nvim
alias vim=nvim

PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH
