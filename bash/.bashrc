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
# TODO: practically infinity, I haven't fully evaluated what exactly these parameters do
# but I'm not leaving them unset as suggested on th internet to note break other applications
export HISTFILESIZE=340282366920938463463374607431768211456
export HISTSIZE=340282366920938463463374607431768211456

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}__prompt_command_fishlike"

__prompt_command_fishlike() {
	local exitCode="$?"
	local gitHash=$(git rev-parse HEAD 2>/dev/null|head -8)
	local gitBranch=$(git symbolic-ref --short -q HEAD 2>/dev/null)
	local gitShow=$([ ! -z "${gitBranch}" ] && echo "${gitBranch}" || echo "${gitHash}")
	PS1=""

	local Reset='\[\e[0m\]'
	local Red='\[\e[0;31m\]'
	local BoldRed='\[\e[1;31m\]'
	local Green='\[\e[0;32m\]'

	#PS1+="${Green}\u${Reset}@\h ${Green}\w${Reset}"
	PS1+="${Green}\w${Reset}"
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

function __include_in_path_if_exists() {
	test -d $1 && PATH="$1:$PATH"
}

__include_in_path_if_exists "$HOME/.config/yarn/global/node_modules/.bin"
__include_in_path_if_exists "$HOME/go/bin"
__include_in_path_if_exists "$HOME/.bin"
__include_in_path_if_exists "/usr/local/sbin"
__include_in_path_if_exists "/usr/local/opt/ruby/bin"
__include_in_path_if_exists "/usr/local/opt/coreutils/libexec/gnubin"
export PATH

set -o vi
export PROMPT_DIRTRIM=3
which vim >/dev/null && EDITOR=vim
which nvim >/dev/null && {
	alias vim=nvim
	EDITOR=nvim
}
export EDITOR

which direnv >/dev/null && eval "$(direnv hook bash)"
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# need this for gpg to play well with pinentry
export GPG_TTY=$(tty)
