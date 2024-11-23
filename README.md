# JRock's Dotfiles

Files for dev environment upkeep and bootstrapping a new environment

## Dev Environment Setup

### OSX
show hidden files
```bash
defaults write com.apple.Finder AppleShowAllFiles YES
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
```

---

### Apps
- 1password
- Notion
- Chrome (turn on sync)
- vscode (enable settings sync)
- iterm2
- Slack/Teams
- spotify
- Docker
- stay (store window locations)

---

### Shell
Change default shell to zsh if necessary:
```bash
chsh -s /bin/zsh
```

Create ssh key:
```bash
ssh-keygen -t rsa -b 4096 -C "email@gmail.com"
```

Modify `~/.ssh/config`:
```bash
Host *
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/id_rsa
```

Add ssh key to ssh-agent
```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

Add public ssh key to github/gitlab

---

### Install Homebrew, Xcode Command Line Tools, git, and tools
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/cask-fonts
brew install --cask aws-vault
brew install --cask rectangle
brew install --cask pgadmin4
brew install --cask postman
brew install git \
awscli \
tree \
jq \
wget \
font-fira-code \
kubectl \

# Remove outdated versions from the cellar
brew cleanup
```

---

### Install OhMyZsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

### dotfiles
clone [dotfiles](https://github.com/velveetachef/dotfiles) to home directory

Symlink files
```bash
ln -sv "$HOME/dotfiles/.gitconfig" "$HOME"
ln -sv "$HOME/dotfiles/.gitignore_global" "$HOME"
ln -sv "$HOME/dotfiles/.mongorc.js" "$HOME"
ln -sv "$HOME/dotfiles/custom.zsh" "$HOME/.oh-my-zsh/custom"
```

---

### Install global npm packages
```bash
npm i -g npm-check-updates
```

---

### Install volta (node/npm management)
```bash
curl https://get.volta.sh | bash
volta install node
```

---

### Install iTerm shell integration
```bash
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
```

---

### Configure kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/

---

### Configure aws-cli
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-where

