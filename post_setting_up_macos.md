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

Adding to `.gitconfig`:

```shell
[alias]
	slog = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
	slog2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
	anc = git add . && git commit -m
```

check : https://gist.github.com/taxilian/1338308

- Install Atom and get its config from Github

- Install iterm2, oh-my-zsh, configure theme (Powerlevel)

- Create aliases:

https://superuser.com/questions/1271179/sourcing-an-alias-file-in-oh-my-zsh-custom-folder

```shell
alias gitfs="git fetch; git status"
alias zshconfig="open ~/.zshrc -a 'Atom'"
alias gitconfig="open ~/.gitconfig -a 'Atom'"
alias dp="cd ~/Documents/projects"
alias lnbib="ln -s /Users/franvillamil/Documents/bib/REF.bib REF.bib"
alias cpbib="cp /Users/franvillamil/Documents/bib/REF.bib ."
alias joinallpdf="'/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py' -o new.pdf *.pdf"
alias gitlf="git rev-list --objects --all |
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
  sed -n 's/^blob //p' |
  sort --numeric-sort --key=2 |
  cut -c 1-12,41-"
```

- Install R (and required packages?)

- Latex

brew install --cask mactex-no-gui
eval "$(/usr/libexec/path_helper)"



- Install others

brew install --cask skim
brew install --cask libreoffice
brew install --cask brave-browser
brew install --cask dropbox
brew install --cask quicksilver
brew install --cask spectacle


- SQL stuff?

- Apps by default? https://superuser.com/a/1092184/1308479
