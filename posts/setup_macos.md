# Setting up a new macOS environment

This is my own guide to set up a new mac computer. It covers the basics for code development (shell, git, R, Latex, code editor, etc) and some other useful applications for academic research.

*TODO*:

- Makevars and gcc stuff
- Spatial stuff, see [this](https://www.alexchubaty.com/post/2016-12-13-using-latest-gdal-macos/) and [this](https://www.alexchubaty.com/post/2020-01-08-using-latest-gdal-macos-redux/)

----
## Basics

Install XCode:

```shell
xcode-select -—install
```

Install Homebrew, and follow instructions in installation:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


#### Annoying system settings

- Disable automatic spelling correction, word capitalisation, and full stop with double-space, in `Keyboard` > `Spelling`
- Enable 'Keyboard navigation' to move panels with `Tab`, in `Accessibility` > `Keyboard`

----
## Shell and iTerm2

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

**NOTE:**

- It's useful to give iTerm2 access to Full disk under Privacy settings, so as to avoid the `operation not permitted` when using `find`
- In Settings > Profiles > Keys, change a couple things so you can move through words with <kbd>alt</kbd> and arrows:
	- In <kbd>⌥</kbd><kbd>-></kbd>, change it to "Send Escape Sequence" and write "f" in Esc+
	- In <kbd>⌥</kbd><kbd><-</kbd>, change it to "Send Escape Sequence" and write "b" in Esc+

----
## Git

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

Add cached credentials to log in locally (see [this guide](https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git)):

```shell
brew install --cask git-credential-manager
```

Just clone any private repository to set it up. Maybe useful to do this afterwards:

```shell
git config --global user.name "Fran Villamil"
git config --global user.email francisco.villamil@uc3m.es
```

#### Extras

**Also install Github CLI (`gh`)**

```shell
brew install gh
```

**Get configurations from `configfiles`:**

Clone [configfiles](https://github.com/franvillamil/configfiles) repository and create symlinks for terminal and git:

```shell
cd
git clone https://github.com/franvillamil/configfiles
rm ~/.zshrc && ln -s ~/configfiles/.zshrc ~/.zshrc
rm ~/.p10k.zsh && ln -s ~/configfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/configfiles/.aliases ~/.oh-my-zsh/custom/aliases.zsh
rm ~/.gitconfig && ln -s configfiles/.gitconfig  ~/.gitconfig
```

**Note:** aliases go in a separate file (`.aliases`, pointed by a symlink in `.oh-my-zsh/custom/`), [see this thread](https://superuser.com/questions/1271179/sourcing-an-alias-file-in-oh-my-zsh-custom-folder).

**Get p4merge (optional):**

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

----
## Other useful software

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
brew install --cask obsidian
brew install --cask google-drive
brew install node
brew install --cask notunes
```

#### Quick configurations

**Spectacle:**

- Allow access to app in Accesibility
- My key strokes:
	- Full screen: <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd>F</kbd>
	- Left half and right half: <kbd>⌃ ctrl</kbd> <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd><-</kbd> / <kbd>-></kbd>
	- Next display: <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd>P</kbd>
	- Upper/lower right: <kbd>⌃ ctrl</kbd> <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd>up arrow</kbd> / <kbd>down arrow</kbd>

**Quicksilver:**

- Allow access to app, iTerm2 plugin, set Catalog
- Keystrokes
	- Quicksilver: <kbd>⌘ cmd</kbd> + <kbd>Space</kbd>
	- Search in Finder: <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd>Space</kbd>
	- Spotlight: <kbd>⌃ ctrl</kbd> <kbd>⌥ alt</kbd> <kbd>⌘ cmd</kbd> + <kbd>Space</kbd>

**Others:**

- Log in to Google Drive and Dropbox
- Install digital certificate
- Set noTunes [to launch at startup](https://github.com/tombonez/noTunes) (General > Login Items)

----
## R installation

- **Important:** Do **NOT** install R through homebrew
- Use standard R installation, through [r-project.org](https://www.r-project.org)
- Change appearance colors
- Get configuration from `configfiles`:

```shell
ln -s ~/configfiles/.Rprofile ~/.Rprofile
ln -s ~/configfiles/.Renviron ~/.Renviron
```

#### `gcc` stuff for compilations in R (in case it's needed)

**NOTE:** check [this post](https://stackoverflow.com/a/43527031/2319134) before. Looks like macOS Ventura comes with `gcc` and `g++` 14, maybe it is enough to point to their location (by default in `/usr/bin/`) in a new `Makevars` file? Instead to download it through Homebrew ([see also this post](https://github.com/bernhardu/dvbcut-deb/issues/13)). But if I do want to do that, follow:

```brew install gcc```

And then add this to `Makevars`, but first check version of `gcc` and directories etc (perhaps need to create it: ```cd && mkdir .R && touch .R/Makevars```):

```
CC = gcc-12
CXX = g++-12
FLIBS = -L/opt/homebrew/lib/gcc/12/gcc/aarch64-apple-darwin20/12 -L/opt/homebrew/lib/gcc/12 -lgfortran -lquadmath -lm
```

#### Extra libraries to use in R

- *TODO:* spatial analyses, etc

## Code editor (Sublime Text)

I have the following packages installed:

- `AutoFileName`
- `BracketHighlighter`
- `FileBrowser`
- `iOpener`
- `LaTeXSmartQuotes`
- `LaTeXTools`
- `Markdown Extended`
- `MarkdownPreview`
- `Package Control`
- `R-IDE`
- `SendCode`
- `SideBarEnhancements`
- `SublimeLinter-contrib-write-good`
- `Sync Settings`
- `Whitespace`
- `WordingStatus`

Configuration is saved in a (private) [git repository](https://github.com/franvillamil/sublime_settings), which also enables syncing. In a new computer, just install `Package Control` and then clone the repository into the following folder, in a new folder called `User`:

```shell
cd Library/Application\ Support/Sublime\ Text/Packages
```

Also, so the `subl` command works:

```shell
sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```

----
## Latex

brew install --cask mactex
eval "$(/usr/libexec/path_helper)"

**NOTE:** I'm not sure it's the best idea to install it through homebrew, [see this post](https://tex.stackexchange.com/a/656177).


Also, install `bibtex-tidy` ([see this](https://github.com/FlamingTempura/bibtex-tidy)) (needs `npm`):

```{shell}
npm install -g bibtex-tidy
```

----
## Extra configurations

#### Add python to PATH

Python3 should be installed by now in homebrew. Maybe check:

```shell
where python3
```

To check the versions installed, try `ls /opt/homebrew/opt/`. Also useful to check `brew info python`. ([See this](https://stackoverflow.com/a/52404561/2319134)).

Now add it to the PATH (careful with version):

```shell
echo 'export PATH=/opt/homebrew/opt/python@3.11/libexec/bin:$PATH' >> ~/.zprofile
source ~/.zprofile
```

#### File type defaults

Install [duti](https://github.com/moretension/duti/):

```shell
brew install duti
```

If you need to check the code for an application, assign it manually and then check the defaults with `duti`:

```shell
duti -x sh
```

And then change some defaults:

- `csv` files with Modern CSV:

    ```shell
    duti -s net.galliumdigital.Modern-CSV .csv all
    ```

- All plain text (txt, R, Markdown, shell, Latex) with Sublime Text:

    ```shell
    duti -s com.sublimetext.4 .txt all
    duti -s com.sublimetext.4 .md all
    duti -s com.sublimetext.4 .R all
    duti -s com.sublimetext.4 .tex all
    duti -s com.sublimetext.4 .sh all
    duti -s com.sublimetext.4 .zsh all
    ```

----
## Further references

- See [this guide](https://sourabhbajaj.com/mac-setup)
