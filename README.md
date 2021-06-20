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
- vscode
- iterm2
- Slack
- spotify
- Notion
- TablePlus
- Excel
- Graphql Playground (installed with brew services)

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
clone `https://github.com/velveetachef/dotfiles` to home directory

Run bootstrap script
```bash
ohmyzsh.sh
bootstrap.sh
```

---

### VSCode
Install package `Settings Sync`

---

