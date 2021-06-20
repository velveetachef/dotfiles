#!/bin/zsh

# Install homebrew if it is not installed
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
    echo "Homebrew not installed. Attempting to install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ ! "$?" -eq 0 ] ; then
        echo "Something went wrong. Exiting..." && exit 1
    fi
fi

brew update
brew upgrade

brew install git
brew install awscli
brew install python
brew install redis
brew install tree
brew install jq
brew install wget
brew install graphql-playground
brew tap mongodb/brew
brew install mongodb-community
brew tap homebrew/cask-fonts
brew install font-fira-code

# Remove outdated versions from the cellar
brew cleanup

brew services start redis
