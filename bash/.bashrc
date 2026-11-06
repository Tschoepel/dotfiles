#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -al --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

export EDITOR=nano
export VISUAL=nano

export MSBuildSDKsPath=$( echo /usr/share/dotnet/sdk/10.*/Sdks );
