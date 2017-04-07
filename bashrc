# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
[ -f "/etc/inputrc" ] && bind -f /etc/inputrc
[ -d "/usr/local/opt/openssl/bin" ] && export PATH="/usr/local/opt/openssl/bin:$PATH"

# EXPORT section
export HISTCONTROL=ignoredups:erasedups
export CLICOLOR=1
export CLICOLOR_FORCE=1
export LSCOLORS=gxfxfxfxcxbxbxDxDxExex
export LS_COLORS='di=36:ln=35:so=35:pi=35:ex=32:bd=31:cd=31:su=1;33:sg=1;33:tw=1;34:ow=34'
export EDITOR=vim

# PROMPT section
function prompt_command
{
	if [ $? -eq 0 ] ; then STATUS=0 ; else STATUS=1 ; fi
}
function red_colon
{
	[ $STATUS -ne 0 ] && printf ":"
}
function white_colon
{
	[ $STATUS -eq 0 ] && printf ":"
}
function rootless_user
{
	[ $EUID -ne 0 ] && printf $(whoami)
}
function root_user
{
	[ $EUID -eq 0 ] && printf $(whoami)
}
COLON="\[\033[1;31m\]\$(red_colon)\[\033[1;30m\]\$(white_colon)"
USER="\[\033[1;32m\]\$(rootless_user)\[\033[1;31m\]\$(root_user)"
AT_HOST="\[\033[1;30m\]@\[\033[1;34m\]\h"
TIME="\[\033[1;33m\]\$(date +%H)\[\033[1;30m\]:\[\033[1;33m\]\$(date +%M)\[\033[1;30m\]:\[\033[1;33m\]\$(date +%S)"
DIR="\[\033[1;36m\]\W\[\033[1;30m\]/"
SEMICOLON="\[\033[1;30m\]; \[\033[1;37m\]"

PROMPT_COMMAND=prompt_command
PS0="\[\033[0m\]"
PS1="${COLON} ${TIME} ${USER}${AT_HOST} ${DIR} ${SEMICOLON}"
PS2=""

# SHOPT section
shopt -s checkwinsize
[ ${BASH_VERSINFO[0]} -ge 4 ] && shopt -s autocd
shopt -s cdspell

# FUNCTIONS section
psgrep()
{
	if [ ! -z $1 ] ; then
		ps aux | grep $1 | grep -v grep
	else
		echo "!! Need name to grep for"
	fi
}
la()
{
	ls -fAFhl | tail -n +4 | grep "^d" | cat
	ls -fAFhl | grep "^-" | cat
	ls -AfFhl | grep -E '^d|^-' -v | grep -v "^total" | cat
}
random-string()
{
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

#ALIASES section
alias grep="grep --color=auto"
alias brew="brew "
alias ddeps="ls | xargs -t -n 1 brew uses --installed --include-options"
