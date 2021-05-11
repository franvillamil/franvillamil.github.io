Install XCode

```shell
xcode-select —install
```

Install Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```



- Install git and check version before/after

```shell
git --version
brew install git
git --version
```

If it doesn't change, try:

```shell
export PATH=/usr/local/bin:$PATH
git --version
```

- Install Atom and get its config from Github

- Install iterm2, oh-my-zsh, configure theme (Powerlevel)

- Create aliases:

https://superuser.com/questions/1271179/sourcing-an-alias-file-in-oh-my-zsh-custom-folder

```shell
alias lnbib="ln -s /Users/franvillamil/Documents/bib/REF.bib REF.bib"
alias joinallpdf="'/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py' -o new.pdf *.pdf"
alias gitfs="git fetch; git status"
```

- Install R (and required packages?)

- Latex

brew install --cask mactex-no-gui
eval "$(/usr/libexec/path_helper)"

- Install others

brew install --cask libreoffice
brew install --cask brave-browser
brew install --cask dropbox
brew install --cask quicksilver
brew install --cask spectacle


- SQL stuff?

- Apps by default? https://superuser.com/a/1092184/1308479
