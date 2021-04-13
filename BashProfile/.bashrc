#
# ~/.bashrc
#

[[ $- != *i* ]] && return  # If not running interactively, don't do anything


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


### DISPLAY ###
LS_COLORS=$LS_COLORS:'di=4;97:'; export LS_COLORS # underline;white
function prompt
{
	source .colorcodes

	# export PS1="\[\033[0;32m\]\u\[\033[1;34m\]@\h\[\033[0;35m\]:\w\[\033[0;36m\] >> \[\033[00m\]"  # 2020.08.01
	export PS1="$MEDIUMPURPLE1\t$AQUA_8_BIT_OR_BRIGHTCYAN_3_4_BIT@\h$GREEN1:\w $RED2>>\[\e[0m\] "  # 2021.04.12
}
prompt
PROMPT_DIRTRIM=3


### PATH ###
## COMMANDS ##
export PATH="$PATH:/Commands/backup/bin"
export PATH="$PATH:/Commands/cdf/bin"
export PATH="$PATH:/Commands/cpu_temp/bin"
export PATH="$PATH:/Commands/create_repo/bin"
export PATH="$PATH:/Commands/encrypt/bin"
export PATH="$PATH:/Commands/decrypt/bin"
export PATH="$PATH:/Commands/mvR/bin"
export PATH="$PATH:/Commands/res/bin"
export PATH="$PATH:/Commands/run/bin"
## JUPYTER LAB ##
export PATH="$PATH:/home/mpzinke/.local/bin"


### ACTIONS ###
setfont iso02.16.gz  # reset font size
neofetch  # show how awesome my computer is

