See [this guide	](https://sourabhbajaj.com/mac-setup)

Install XCode:

```shell
xcode-select -—install
```

Install Homebrew, and follow instructions in installation:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install iTerm2, and oh-my-zsh:

```shell
brew install --cask iterm2
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

In older versions installing `zsh` might be necessary. Also, if you get an error like `/Users/../.zshrc:source:75: no such file or directory: /Users/../.oh-my-zsh/oh-my-zsh.sh`, uninstall and install oh-my-zsh again.

Install Powerlevel10k theme, close iTerm2, open again and go through configuration wizard:

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

Install git via homebrew and check that version has changed been updated:

```shell
git --version
brew install git
git --version
```

If version doesn't change, try:

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

- Install iterm2, oh-my-zsh, configure theme (Powerlevel)

- Install Atom/VSCodium and get its config from Github

**NICE**: https://gist.github.com/the0neWhoKnocks/ba019a86e5d4a30e5076b5af05f1b04f

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

- VS Codium

brew install --cask vscodium


- Install others

```
brew install pandoc
brew install pandoc-crossref
brew install --cask skim
brew install --cask brave-browser
brew install --cask dropbox
brew install --cask quicksilver
brew install --cask spectacle
brew install --cask modern-csv
brew install --cask spotify
brew install --cask autofirma
brew install --cask adobe-acrobat-reader
brew install --cask firefox
brew install --cask gimp
brew install --cask protonvpn
brew install --cask selfcontrol
brew install --cask skype
brew install --cask zoom
brew install --cask zotero
brew install --cask calibre
```

Maybe also `[duti](https://github.com/moretension/duti/)` and set up defaults for extensions:

```
brew install duti
```

And then (change Atom for VSCode):

```
duti -s com.github.atom .md all
duti -s net.galliumdigital.Modern-CSV .cst all
```


- Git stuff

```
brew install --cask p4v
```

The configuration for git should already be in `configfiles`, but just in case, it is:

```
[diff]
    tool = p4mergetool
    renames = copies
    mnemonicprefix = true
[difftool "p4mergetool"]
    cmd = /Applications/p4merge.app/Contents/MacOS/p4merge "$LOCAL" "$REMOTE"
    keepBackup = false
    keepTemporaries = false
    trustExitCode = false
    prompt = false
 ```



- SQL stuff?

- Apps by default? https://superuser.com/a/1092184/1308479



R gcc stuff:
```brew install gcc```

And then add this to `Makevars`, but first check version of `gcc` and directories etc (perhaps need to create it: ```cd && mkdir .R && touch .R/Makevars```):

```
CC = gcc-12
CXX = g++-12
FLIBS = -L/opt/homebrew/lib/gcc/12/gcc/aarch64-apple-darwin20/12 -L/opt/homebrew/lib/gcc/12 -lgfortran -lquadmath -lm
```
