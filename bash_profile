export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/Cellar/vim
export PATH=$PATH:/usr/local/Cellar/gcc/7.1.0/bin
export PATH=$PATH:/usr/local/Cellar/python
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:~/bin

alias ls="ls -G"
alias ll="ls -lhG"
# ssh
alias pullcode="scp -r zhy@10.21.2.185:~/dataset/src Desktop/"
alias jumpw="ssh -fNT -D 8192 root@168.235.98.214"
alias ict="ssh -X -R 10086:localhost:22 zhy@10.21.2.185"
alias inict="ssh -X ucas@10.21.2.192"
alias outict="ssh -p 10022 -X ucas@159.226.40.200"
alias showports="lsof -Pn -i4 | grep LISTEN"
alias amazonvps="ssh -i hk.pem ubuntu@ec2-18-163-28-229.ap-east-1.compute.amazonaws.com"
#conda
. /Users/zhaohuaiyi/anaconda3/etc/profile.d/conda.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# For prompt
if [[ -f ~/.bash_prompt ]]; then source ~/.bash_prompt; fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

