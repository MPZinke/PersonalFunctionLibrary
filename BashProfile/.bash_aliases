
### FOLDERS ###
alias ls='gls --color'
alias la='gls -a --color'
alias ll='gls -l --color'
alias sublime='/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text'
alias ws='cd ~/Main/Workspace'
alias main='cd ~/Main'

### GIT ###
alias git_untrack='git update-index --assume-unchanged'
alias git_track='git update-index --no-assume-unchanged'
alias git_tree='git log --graph --oneline --all'

### EXTERNAL CONNECTIONS ###
alias shtdn="ssh -t mpzinke@mpzinke-arch 'sudo shutdown now'"
alias wake_arch_remote='wakeonlan -i mpzinke-arch-remote -p 32767 00:xx:xx:xx:xx:xx'
alias suspend_arch_remote="ssh -p 22 -t mpzinke@mpzinke-arch-remote 'sudo systemctl suspend'"
alias remove_host='ssh-keygen -R'  # ssh


### SCHOOL ###
alias 4317='cd /Users/mpzinke/Courses/CSE4317'
alias 4323='cd /Users/mpzinke/Courses/CSE4323'
alias 4344='cd /Users/mpzinke/Courses/CSE4344'
alias 4351='cd /Users/mpzinke/Courses/CSE4351'

### PERSONAL COMMANDS ###
alias cdf='source cdf'
create_remote_repo()
{
	ssh -t mpzinke@mpzinke-arch "/Commands/create_repo/bin/create_repo $1"
}

curl_file()
{
	curl -o "$(basename $1)" $1
}

### OTHER ###
alias is_dad_home="ping 10.0.0.xx"
alias clean='clear && neofetch'
