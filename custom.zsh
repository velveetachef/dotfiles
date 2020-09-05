#--------------------------------------
# python
#--------------------------------------
alias python='/usr/local/bin/python3'

#--------------------------------------
# start and stop postgres
#--------------------------------------
alias startpg='docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=root -d --restart=always --volumes-from postgres_vol postgres'
alias stoppg='docker rm -f postgres'

#--------------------------------------
# enable and disable package-lock
#--------------------------------------
alias plockon='npm config set package-lock true'
alias plockoff='npm config set package-lock false'

#--------------------------------------
# git
#--------------------------------------
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gfg='git ls-files | grep'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gm='git merge'
# alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
alias grhh='git reset --hard'
alias grm='git rm'
alias gss='git status -s'
alias gst='git status'
alias gts='git tag -s'
alias gtv='git tag | sort -V'

function gpull() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}

function gpush() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}

#--------------------------------------
# CBT
#--------------------------------------
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
alias startlxqats='ASSUME_ROLE=true NODE_ENV=cbtn-lx-qa LOCAL_ENV=true NODE_LOGGER_CONSOLE=true NODE_LOGGER_CONSOLE_LEVEL=debug NODE_PATH=/app/dist/src node /dist/src/app.js'
alias startprod='NODE_ENV=prod node app.js'

# generate token shortcuts
alias qatoken='cbt -e qa auth get_token'
alias prodtoken='cbt -e prod auth get_token'
alias qatokenid='cbt -e qa auth get_token_for_user --user_id'
alias prodtokenid='cbt -e prod auth get_token_for_user --user_id'

# set NPM Registry
alias npm-default='npm config set registry https://registry.npmjs.org && yarn config set registry https://registry.npmjs.org'
alias npm-cbt='npm config set registry http://npm.aws.cbtnuggets.com  && yarn config set registry http://npm.aws.cbtnuggets.com'

#--------------------------------------
# Start Dynamo Local
#--------------------------------------
function startdynamo() {
  cd ~/.dynamolocal
  # must have java
  java -Djava.library.path=./DynamoDBLocal_lib/ -jar DynamoDBLocal.jar
}

#--------------------------------------
# Start Mongo Local
#--------------------------------------
alias mongodlocal='mongod --dbpath /usr/local/var/mongodb'
