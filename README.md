# wip:dotfiles

## Installation

### Using Git and the bootstrap script
You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.
```
git clone https://github.com/karan/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, cd into your local dotfiles repository and then:
```
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:
```
set -- -f; source bootstrap.sh
```

### Git-free install
To install these dotfiles without Git:
```
cd; curl -#L https://github.com/karan/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}
```

To update later on, just run that command again.

### Install Homebrew formulae
When setting up a new Mac, you may want to install some common Homebrew formulae (after installing Homebrew, of course):
```
./brew.sh
```
