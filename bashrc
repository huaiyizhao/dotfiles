export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:~/bin
export PYTHONPATH=/usr/lib/python3.4/site-packages/

# for easy use of gdb and gcc
#alias gcc="gcc-10"

#alias g++="g++ -stdlib=libc++"
#alias gcc="gcc -stdlib=libc++"

#alias g++="g++-10"
#alias gdb="sudo gdb"
# use vi style command line input
#set -o vi
alias ls="ls -G"
alias ll="ls -lhG"
alias python="python3"
alias pip="pip3"
# ssh
alias jptt="ssh -N -f -L localhost:9999:localhost:8888 ict"
alias jpttcnic="ssh -N -f -L localhost:9999:localhost:8888 cnic"
alias gssh="ps aux | grep ssh"
alias showports="lsof -Pn -i4 | grep LISTEN"
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

for f in /usr/local/etc/bash_completion.d/*; do
    source $f;
done


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

