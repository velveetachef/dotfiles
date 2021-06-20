#!/bin/zsh

install_brew () {
	echo "Installing Homebrew and utilities"
    brew.sh
    echo "Brew installation complete"
}

install_tools() {
    echo "Enabling iterm2 shell integration"
    curl -L https://iterm2.com/shell_integration/zsh \
    -o ~/.iterm2_shell_integration.zsh

    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

    echo "Install tools complete"
}

download_dynamo_local() {
    echo "install dynamo local"
    echo "Proceed? (y/n)"
	read resp

	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz -P ~/Downloads
        mkdir ~/.dynamolocal
        tar -xvzf ~/Downloads/dynamodb_local_latest.tar.gz -C ~/.dynamolocal
		echo "dynamo local install complete"
	else
		echo "dynamo local install skipped by user"
	fi
}

link () {
	echo "Symlink files to the home directory"
    echo "Proceed? (y/n)"
	read resp

	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        ln -sv "$HOME/dotfiles/.gitconfig" "$HOME"
        ln -sv "$HOME/dotfiles/.gitignore_global" "$HOME"
        ln -sv "$HOME/dotfiles/.mongorc.js" "$HOME"
        ln -sv "$HOME/dotfiles/custom.zsh" "$HOME/.oh-my-zsh/custom"

		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

install_brew
install_tools
download_dynamo_local
link
