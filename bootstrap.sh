#!/bin/zsh

install_brew () {
	echo "Installing Homebrew and utilities"
    brew.sh
    echo "Brew installation complete"
}

install_tools() {
    echo "Installing ohMyZsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "Enabling iterm2 shell integration"
    curl -L https://iterm2.com/shell_integration/zsh \
    -o ~/.iterm2_shell_integration.zsh

    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

    echo "Install tools complete"
}

link () {
	echo "Symlink files to the home directory"
    echo "Proceed? (y/n)"
	read resp

	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        ln -sv "$PWD/.gitconfig" "$HOME"
        ln -sv "$PWD/.gitignore_global" "$HOME"
        ln -sv "$PWD/.mongorc.js" "$HOME"
        ln -sv "$PWD/my_custom_zsh" "$HOME/.oh-my-zsh/custom"

		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

install_brew
install_tools
link
