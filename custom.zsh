#--------------------------------------
# python
#--------------------------------------
# alias python='/usr/local/bin/python3'

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
alias gcmsg='git commit -m'
alias gc!='git commit -v --amend'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gcd='git checkout develop'
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

# #--------------------------------------
# # Start Dynamo Local
# #--------------------------------------
# function startdynamo() {
#   cd ~/.dynamolocal
#   # must have java
#   java -Djava.library.path=./DynamoDBLocal_lib/ -jar DynamoDBLocal.jar
# }

#--------------------------------------
# Start Mongo Local
#--------------------------------------
alias mongodlocal='mongod --dbpath /usr/local/var/mongodb'
