#!/usr/bin/env bash

# Install homebrew if it is not installed
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo "Homebrew not installed. Attempting to install Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	if [ ! "$?" -eq 0 ] ; then
		echo "Something went wrong. Exiting..." && exit 1
	fi
fi

brew update
brew upgrade

# Python 3
brew install git
brew install awscli
brew install python
brew install redis
brew install tree
brew install jq

brew tap mongodb/brew
brew install mongodb-community

# Remove outdated versions from the cellar
brew cleanup