sudo apt-get install vim 
sudo apt-get install tmux 
sudo apt-get install zsh
cp .vimrc ~/.vimrc
cp .tmux.conf.local ~/.tmux.conf.local
cp .tmux.conf ~/.tmux.conf
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -E -s -u "~/.vimrc" +PlugInstall +qall
sudo apt install build-essential cmake python3-dev
python3 ~/.vim/bundle/YouCompleteme/install.py --clang-completer
sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc 
