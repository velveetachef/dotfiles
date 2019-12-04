# JRock's Dotfiles

Files for dev environment upkeep and bootstrapping a new environment

## Dev Environment Setup

### OSX
show hidden files
```bash
defaults write com.apple.Finder AppleShowAllFiles YES
killall Finder
```

---

### Apps
- dropbox
- 1password6
- vscode
- iterm2
- evernote
- postman
- spectacle
- Slack
- Sonos
- spotify
- Notion
- TablePlus
- Excel
- Graphql Playground (installed with brew services)

---

### Homebrew
Install
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install brews
```bash
brew update
brew upgrade

brew install zsh
brew install git
brew install awscli
brew install python
brew install redis
brew install tree
brew install jq
brew cask install graphql-playground

brew tap mongodb/brew
brew install mongodb-community

# Remove outdated versions from the cellar
brew cleanup

brew services start redis
```

---

### Shell
Change default shell to zsh if necessary:
```bash
chsh -s /bin/zsh
```

Install OhMyZsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Enable iTerm2 shell integration
```bash
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
```

---

Create ssh key:
```bash
ssh-keygen -t rsa -b 4096 -C "email@gmail.com"
```

Modify `~/.ssh/config`:
```
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

### dotfiles
clone https://github.com/velveetachef/dotfiles
symlink all files to home directory
```bash
Automate this step
```

---

Create mongodb data directory and ensure correct permissions
```bash
sudo mkdir -p /data/db
sudo chown -R `id -un` /data/db
```

### git
```bash
git config --global user.name username
git config --global user.email email@gmail.com
```

---

### NVM

```bash
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
```

---

### VSCode
Install package `Settings Sync`

---

