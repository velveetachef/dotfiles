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
# zsh
#--------------------------------------
alias zshconfig="cursor ~/.zshrc"
alias ohmyzsh="cursor ~/.oh-my-zsh"

#--------------------------------------
# npm
#--------------------------------------
alias listglobal='npm list -g --depth 0'

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

alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
alias grhh='git reset --hard'
alias grm='git rm'
alias gss='git status -s'
alias gst='git status'
alias gts='git tag -s'
alias gtv='git tag | sort -V'

#--------------------------------------
# Start Mongo Local
#--------------------------------------
alias mongodlocal='mongod --dbpath /usr/local/var/mongodb'

#--------------------------------------
# Github pull and push current branch
#--------------------------------------
function gpull() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" -eq 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}

function gpush() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" -eq 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}

function setLocalConfig() {
  g config user.name "Jeremy Sabat"
  g config user.email jsabat@esri.com
}

#--------------------------------------
# k8s eks switch
# set kube context
#--------------------------------------
function eks_switch() {
  # Initialize debug flag
  DEBUG=0

  # Parse command-line options
  while getopts "d" option; do
    case $option in
      d) DEBUG=1 ;;
      *) echo "Usage: eks_switch [-d]"; return 1 ;;
    esac
  done

  # Function to print debug messages if debug is enabled
  debug() {
    if [ $DEBUG -eq 1 ]; then
      echo "$1"
    fi
  }

  # Fetch all AWS regions in JSON format
  echo "Fetching list of AWS regions..."
  regions=$(aws ec2 describe-regions --output json)
  debug "Available regions: $regions"

  # Parse the region names using jq into a newline-separated list
  region_array=($(echo "$regions" | jq -r '.Regions[].RegionName'))

  # Initialize an empty array to store clusters
  cluster_list=()

  # Temporary file to store cluster information
  tmpfile=$(mktemp /tmp/eks_clusters.XXXXXX)

  # Function to fetch clusters in parallel
  fetch_clusters() {
    local region=$1
    debug "Checking region: $region"
    clusters=$(aws eks list-clusters --region "$region" --output json)
    region_clusters=($(echo "$clusters" | jq -r '.clusters[]'))
    for cluster in "${region_clusters[@]}"; do
      echo "$region:$cluster" >> "$tmpfile"
    done
  }

  # Fetch clusters from all regions in parallel
  echo "Fetching list of clusters from all regions..."

  if [ $DEBUG -eq 0 ]; then
    set +m
  fi

  for region in "${region_array[@]}"; do
    fetch_clusters "$region" &
  done
  wait

  if [ $DEBUG -eq 0 ]; then
    set -m
  fi

  # Read clusters from the temporary file
  while IFS= read -r cluster; do
    cluster_list+=("$cluster")
  done < "$tmpfile"
  rm "$tmpfile" # Clean up the temporary file

  # Check if there are any clusters
  if [ ${#cluster_list[@]} -eq 0 ]; then
    echo "No EKS clusters found in any region"
    return 1
  fi

  echo "Fetched EKS Clusters from all regions:"

  # Display clusters with numbering
  index=1
  for cluster_info in "${cluster_list[@]}"; do
    cluster_region="${cluster_info%%:*}"
    cluster_name="${cluster_info##*:}"
    echo "$index) $cluster_name (Region: $cluster_region)"
    index=$((index + 1))
  done

  # Prompt the user to select a cluster
  echo -n "Enter the number of the cluster you want to switch to: "
  read -r cluster_number

  cluster_index=$((cluster_number))
  debug "Calculated cluster_index: $cluster_index"

  # Validate selection
  if [ "$cluster_index" -lt 0 ] || (( cluster_index >= ${#cluster_list[@]} + 1 )); then
    echo "Invalid selection. Please enter a valid number."
    return 1
  fi

  selected_cluster_info="${cluster_list[$cluster_index]}"
  selected_region="${selected_cluster_info%%:*}"
  selected_cluster="${selected_cluster_info##*:}"

  debug "selected_cluster_info: $selected_cluster_info"
  debug "selected_region: $selected_region"
  debug "selected_cluster: $selected_cluster"

  if [ -z "$selected_cluster" ]; then
    echo "Invalid selection. Please enter a valid number."
    return 1
  fi

  debug "Selected cluster: '$selected_cluster'"
  debug "Selected region: '$selected_region'"

  # Update kubeconfig and switch context
  aws eks --region "$selected_region" update-kubeconfig --name "$selected_cluster" > /dev/null 2>&1
  kubectl config use-context "arn:aws:eks:${selected_region}:$(aws sts get-caller-identity --query Account --output text):cluster/$selected_cluster" > /dev/null 2>&1

  echo "Switched to cluster: $selected_cluster in region $selected_region"
}

#--------------------------------------
# k8s eks get_token
#--------------------------------------
function eks_get_token() {
  # Initialize debug flag
  DEBUG=0

  # Parse command-line options
  while getopts "d" option; do
    case $option in
      d) DEBUG=1 ;;
      *) echo "Usage: eks_get_token [-d]"; return 1 ;;
    esac
  done

  # Function to print debug messages if debug is enabled
  debug() {
    if [ $DEBUG -eq 1 ]; then
      echo "$1"
    fi
  }

  # Fetch all AWS regions in JSON format
  echo "Fetching list of AWS regions..."
  regions=$(aws ec2 describe-regions --output json)
  debug "Available regions: $regions"

  # Parse the region names using jq into a newline-separated list
  region_array=($(echo "$regions" | jq -r '.Regions[].RegionName'))

  # Initialize an empty array to store clusters
  cluster_list=()

  # Temporary file to store cluster information
  tmpfile=$(mktemp /tmp/eks_clusters.XXXXXX)

  # Function to fetch clusters in parallel
  fetch_clusters() {
    local region=$1
    debug "Checking region: $region"
    clusters=$(aws eks list-clusters --region "$region" --output json)
    region_clusters=($(echo "$clusters" | jq -r '.clusters[]'))
    for cluster in "${region_clusters[@]}"; do
      echo "$region:$cluster" >> "$tmpfile"
    done
  }

  # Fetch clusters from all regions in parallel
  echo "Fetching list of clusters from all regions..."

  if [ $DEBUG -eq 0 ]; then
    set +m
  fi

  for region in "${region_array[@]}"; do
    fetch_clusters "$region" &
  done
  wait

  if [ $DEBUG -eq 0 ]; then
    set -m
  fi

  # Read clusters from the temporary file
  while IFS= read -r cluster; do
    cluster_list+=("$cluster")
  done < "$tmpfile"
  rm "$tmpfile" # Clean up the temporary file

  # Check if there are any clusters
  if [ ${#cluster_list[@]} -eq 0 ]; then
    echo "No EKS clusters found in any region"
    return 1
  fi

  echo "Fetched EKS Clusters from all regions:"

  # Display clusters with numbering
  index=1
  for cluster_info in "${cluster_list[@]}"; do
    cluster_region="${cluster_info%%:*}"
    cluster_name="${cluster_info##*:}"
    echo "$index) $cluster_name (Region: $cluster_region)"
    index=$((index + 1))
  done

  # Prompt the user to select a cluster
  echo -n "Enter the number of the cluster you want to get a token for: "
  read -r cluster_number

  cluster_index=$((cluster_number))
  debug "Calculated cluster_index: $cluster_index"

  # Validate selection
  if [ "$cluster_index" -lt 0 ] || (( cluster_index >= ${#cluster_list[@]} + 1)); then
    echo "Invalid selection. Please enter a valid number."
    return 1
  fi

  selected_cluster_info="${cluster_list[$cluster_index]}"
  selected_region="${selected_cluster_info%%:*}"
  selected_cluster="${selected_cluster_info##*:}"

  debug "selected_cluster_info: $selected_cluster_info"
  debug "selected_region: $selected_region"
  debug "selected_cluster: $selected_cluster"

  if [ -z "$selected_cluster" ]; then
    echo "Invalid selection. Please enter a valid number."
    return 1
  fi

  debug "Selected cluster: '$selected_cluster'"
  debug "Selected region: '$selected_region'"

  # Get the EKS token and copy it to the clipboard
  token=$(aws eks get-token --cluster-name "$selected_cluster" --region "$selected_region" | jq -r '.status.token')
  if [ $? -ne 0 ]; then
    echo "Failed to get token for cluster $selected_cluster in region $selected_region"
    return 1
  fi

  debug "Fetched token: $token"
  echo "$token" | pbcopy

  echo "Token for cluster $selected_cluster in region $selected_region has been copied to the clipboard."
}

#--------------------------------------
# k8s eks get_token
# ~ aws-vault exec prod-admin
# ~ get-vscode-launch
#--------------------------------------
function get_vscode_launch() {
  # Define the list of parameter names
  parameter_names=(
    "/hub-engagement/vscode-launch"
    "/hub-telemetry/vscode-launch"
    "/hub-discussions/vscode-launch"
  )

  # Prompt the user to select a parameter name
  echo "Select the launch configuration:"
  select parameter_name in "${parameter_names[@]}"; do
    if [[ -n "$parameter_name" ]]; then
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done

  # Fetch the parameter value from AWS Parameter Store
  parameter_value=$(aws ssm get-parameter --name "$parameter_name" --with-decryption --query "Parameter.Value" --output text)

  if [[ -n "$parameter_value" ]]; then
  # Decode the Base64 string and decompress the gzip content
    decoded_value=$(echo "$parameter_value" | base64 --decode | gzip -d)
    # Copy the parameter value to the clipboard
    if command -v pbcopy &> /dev/null; then
      echo "$decoded_value" | pbcopy
      echo "Parameter value copied to clipboard."
    elif command -v xclip &> /dev/null; then
      echo "$decoded_value" | xclip -selection clipboard
      echo "Parameter value copied to clipboard."
    else
      echo "Clipboard utility not found. Please install pbcopy (macOS) or xclip (Linux)."
    fi
  else
    echo "Parameter not found."
  fi
}

# Tab completion setup for zsh
if [ -n "$ZSH_VERSION" ]; then
  _eks_get_token() {
    reply=($(for region in $(aws ec2 describe-regions --output json | jq -r '.Regions[].RegionName'); do
      aws eks list-clusters --region "$region" --output json | jq -r '.clusters[]'
    done))
  }
  compctl -K _eks_get_token eks_get_token

  _eks_switch() {
    reply=($(for region in $(aws ec2 describe-regions --output json | jq -r '.Regions[].RegionName'); do
      aws eks list-clusters --region "$region" --output json | jq -r '.clusters[]'
    done))
  }
  compctl -K _eks_switch eks_switch
fi
