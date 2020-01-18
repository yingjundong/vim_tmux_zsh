# vim_tmux_and_zsh
For Ubuntu, I'm using 19.10.

# Installation

If you don't have Vim, tmux and zsh, please install first.

### Ubuntu
`sudo apt-get install vim`

`sudo apt-get install tmux`

`sudo apt-get install zsh`

### MacOS

First step, you need to install Homebrew if you didn't install it. See the web: https://brew.sh/.

After that:

`brew install vim`

`brew install tmux`

`brew install zsh`

# .vimrc and compile

Next

`git clone https://github.com/yingjundong/vim_tmux_zsh.git`

Then, open this folder and copy files to path ~/

`cp vim_tmux_zsh/.vimrc ~/.vimrc`

Install vundle:

`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Open your .vimrc.

`vim ~/.vimrc`

In command mode, insert:

`:PluginInstall`

Install YCM and complie: (YCM official site: https://github.com/ycm-core/YouCompleteMe )

### Ubuntu

`sudo apt install build-essential cmake python3-dev`

`cd ~/.vim/bundle/YouCompleteMe`

`python3 install.py --clang-completer`

### MacOS

`brew install cmake macvim`

`cd ~/.vim/bundle/YouCompleteMe`

`./install.py --clang-completer`

# Vim colorscheme

Move Vim color scheme folder:

`mv ~/.vim/bundle/colorscheme/colors ~/.vim/`

# tmux & zsh

After above process, copy tmux configure files:

`cp .tmux.conf.local ~/.tmux.conf.local`

`cp .tmux.conf ~/.tmux.conf`

Install oh my zsh (oh-my-zsh official site: https://github.com/ohmyzsh/ohmyzsh ):

`sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

Move .zshrc to ~/

`cp vim_tmux_zsh/.zshrc ~/.zshrc`

Open .zshrc, modify the export path:

`vim ~/.zshrc`

Line 5, `export ZSH="YOUR_PATH/.oh-my-zsh"` (Usually, for mac user, this path should be `"/Users/xxx/.oh-my-zsh"`; for ubuntu user, it should be `"/home/xxx/.oh-my-zsh"`.)

Save .zshrc and quit terminal.

Reopen terminal, insert tmux, done.
