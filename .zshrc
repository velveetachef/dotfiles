# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jeremysabat/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git nvm)

# # brew autocompletion (must proceed sourcing oh-my-zsh)
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
# fi

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code -w'
else
  export EDITOR='mvim'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# python
alias python='/usr/local/bin/python3'

# start and stop postgres
alias startpg='docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -d --restart=always --volumes-from postgres_vol postgres'
alias stoppg='docker rm -f postgres'

#-------
# CBT
#-------
export NODE_ENV=development
export LOCAL_ENV=true
export NODE_LOGGER_CONSOLE=true
export NODE_LOGGER_CONSOLE_LEVEL=debug
export SKIP_BOT_MESSAGES=true

# mongo env and node server shortcuts
alias qamongo="mongo --host mongo.database.qa.us-east-1.nuggets.local --eval 'rs.slaveOk()' --shell"
alias pmongo="mongo --host mongo.database.prod.us-east-1.nuggets.local --eval 'rs.slaveOk()' --shell"
alias nodetest='NODE_ENV=test npm test'
alias startqa='NODE_ENV=qa node app.js'
alias startlxqa='NODE_ENV=cbtn-lx-qa ASSUME_ROLE=true node app.js'
alias startprod='NODE_ENV=prod node app.js'

# generate token shortcuts
alias qatoken='cbt -e qa auth get_token'
alias prodtoken='cbt -e prod auth get_token'
alias qatokenid='cbt -e qa auth get_token_for_user --user_id'
alias prodtokenid='cbt -e prod auth get_token_for_user --user_id'

# set NPM Registry
alias npm-default='npm config set registry https://registry.npmjs.org && yarn config set registry https://registry.npmjs.org'
alias npm-cbt='npm config set registry http://npm.aws.cbtnuggets.com  && yarn config set registry http://npm.aws.cbtnuggets.com'




# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

####### Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

######### Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

######### Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

############ Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13


# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder