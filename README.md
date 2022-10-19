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
- vscode (enable settings sync)
- iterm2
- Slack
- spotify
- Notion
- Docker
- stay

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
ssh-add -K ~/.ssh/id_rsa
```

Add public ssh key to github/gitlab

---

### Install Homebrew, Xcode Command Line Tools, git, and tools
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/cask-fonts
brew install git \
awscli \
# redis \
tree \
jq \
wget \
font-fira-code \
--cask rectangle \
kubectl

# Remove outdated versions from the cellar
brew cleanup
```

---

### dotfiles
clone [dotfiles](https://github.com/velveetachef/dotfiles) to home directory

---

### Install OhMyZsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

### Install iTerm shell integration
```bash
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
```

---

### Install nvm
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```

---

### Symlink Files
```bash
ln -sv "$HOME/dotfiles/.gitconfig" "$HOME"
ln -sv "$HOME/dotfiles/.gitignore_global" "$HOME"
ln -sv "$HOME/dotfiles/.mongorc.js" "$HOME"
ln -sv "$HOME/dotfiles/custom.zsh" "$HOME/.oh-my-zsh/custom"
```

---

### Configure kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/


