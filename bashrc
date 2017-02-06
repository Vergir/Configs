# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
[ -f "/etc/inputrc" ] && bind -f /etc/inputrc

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
DIR="\[\033[1;36m\]\W\[\033[1;30m/\]"
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
dirsize ()
{
	du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
	egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
	egrep '^ *[0-9.]*M' /tmp/list
	egrep '^ *[0-9.]*G' /tmp/list
	rm -rf /tmp/list
}

cpg ()
{
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

mvg ()
{
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

ziprm ()
{
	if [ -f $1 ] ; then
		unzip $1
		rm $1
	else
		echo "Need a valid zipfile"
	fi
}

psgrep()
{
	if [ ! -z $1 ] ; then
		echo "Grepping for processes matching $1..."
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

#ALIASES section
alias grep="grep --color=auto"
