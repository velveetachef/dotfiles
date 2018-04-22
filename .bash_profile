echo "Loading ~/.bash_profile a shell script that runs in every new terminal you open"
echo "Logged in as $USER at $(hostname)"

# Path changes are made non-destructive with PATH=new_path;$PATH   This is like A=A+B so we preserve the old path

# Path order matters, putting /usr/local/bin: before $PATH
# ensures brew programs will be seen and used before another program
# of the same name is called

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT_COMMAND='PS1="${c_path}\w${c_reset}$(git_prompt) :> "'
export PS1='\n\[\033[0;31m\]\W\[\033[0m\]$(git_prompt)\[\033[0m\]:> '

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(Git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
# Force ls to include (.) directories (a), use long format (l), use colors (G), and use humanized file sizes (h)
alias ls='ls -alGh'

# Force grep to always use the color option and show line numbers
# This is breaking nvm install
# export GREP_OPTIONS='--color=always'

# Set atom as the default editor
which -s atom && export EDITOR='atom --wait'

# mongo env and node server shortcuts
alias qamongo="mongo --host 172.18.31.149 --eval 'rs.slaveOk()' --shell"
alias pmongo="mongo --host 172.18.31.177 --eval 'rs.slaveOk()' --shell"
alias nodetest='NODE_ENV=test npm test'
alias startqa='NODE_ENV=qa node app.js'
alias startproduction='NODE_ENV=production node app.js'
alias startprod='NODE_ENV=prod node app.js'

# cbt env variables
export NODE_ENV=development
export LOCAL_ENV=true
export NODE_LOGGER_CONSOLE=true
export NODE_LOGGER_CONSOLE_LEVEL=debug
export SKIP_BOT_MESSAGES=true

# generate token shortcut
alias qatoken='cbt -e qa auth get_token'
alias prodtoken='cbt -e prod auth get_token'

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iterm2 tab names and colors
[ -s "${HOME}/.iterm2_helpers.sh" ] && . "${HOME}/.iterm2_helpers.sh"
test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"

# start and stop Redis server
alias redisstart='sudo launchctl start io.redis.redis-server'
alias redisstop='sudo launchctl stop io.redis.redis-server'

# start and stop postgres
alias startpg='docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -d --restart=always --volumes-from postgres_vol postgres'
alias stoppg='docker rm -f postgres'

# Avoid duplicates in history
export HISTCONTROL=ignoredups:erasedups
