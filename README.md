# vim_and_tmux
For Ubuntu, I'm using 19.10.

Run run.sh file

OR

Step by step

If you don't have Vim, tmux and zsh, please install first.

`sudo apt-get install vim`

`sudo apt-get install tmux`

`sudo apt-get install zsh`

Then, open this folder and copy files to ~/.

`cp vim_tmux_zsh/.vimrc ~/.vimrc`

Install vundle:
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Open your .vimrc.

`vim ~/.vimrc`

In command mode, insert:

`:PluginInstall`

Install YCM and complie:
`sudo apt install build-essential cmake python3-dev`

`cd ~/.vim/bundle/YouCompleteMe`

`python3 install.py --clang-completer`

After above process, copy tmux configure files:

`cp .tmux.conf.local ~/.tmux.conf.local`

`cp .tmux.conf ~/.tmux.conf`

Install oh my zsh:

`sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

Move .zshrc to ~/

`cp vim_tmux_zsh/.zshrc ~/.zshrc`
