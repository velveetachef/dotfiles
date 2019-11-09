echo "Loading ~/.bash_profile"
echo "Logged in as $USER at $(hostname)"

source .exports
source .functions
source .aliases

# iterm2 tab names and colors
[ -s "${HOME}/.iterm2_helpers.sh" ] && . "${HOME}/.iterm2_helpers.sh"
test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# Load .bashrc if the shell is interactive
case $- in *i*) . ~/.bashrc;; esac
