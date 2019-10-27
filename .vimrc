set nocompatible
set textwidth=100
set backspace=indent,eol,start 
set cc=100

autocmd BufWritePost $MYVIMRC source $MYVIMRC

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
augroup ycm_settings:
	autocmd!
	let g:ycm_autoclose_preview_window_after_insertion = 1
	let g:ycm_autoclose_preview_window_after_completion = 1
	let g:ycm_goto_buffer_command = 'horizontal-split'
	let g:ycm_python_binary_path = 'python'
	let g:ycm_seed_identifiers_with_syntax = 1
	nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
augroup END

Plugin 'flazz/vim-colorschemes'	
syntax enable 
colorscheme black_is_the_color

Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
Plugin 'kien/rainbow_parentheses.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

nnoremap <F8> :TagbarToggle<CR>

set cursorline 

set t_Co=256
set laststatus=2
let g:airline#entensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_themes = 'badwolf'

map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>

Plugin 'taglist.vim'
map <F3> :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidt=25

Plugin 'scrooloose/nerdtree.git'
map <F2> :NERDTreeToggle<CR>
let NERDTreeWinSize=25

Plugin 'indentLine.vim'
Plugin 'delimitMate.vim'

call vundle#end()

nmap ww :update<cr>
nmap qq :q
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
vmap <C-c> "+y

set autoread
autocmd FileType c,cpp, map <buffer> <leader><space> :w<cr>:make<cr>
set completeopt=preview,menu
filetype plugin on
set clipboard=unnamed
set autowrite
set ruler
set nobackup
set cursorline
set magic

set guifont=Monaco:h16

set nocompatible
set syntax=on
set noeb
set confirm
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set number
set history=1000
set nobackup
set noswapfile
set ignorecase
set hlsearch
set incsearch
set gdefault
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=en_us
set helplang=en

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=[%F]%y%r%m%*%=[Line:%l%L,Column:%c][%p%%]
set laststatus=2
set cmdheight=2
filetype on
filetype plugin on
filetype indent on
set iskeyword+=_,$,@,%,#,-
set linespace=0
set wildmenu
set backspace=2
set whichwrap+=<,>,h,l

set mouse=a
set selection=exclusive
set selectmode=mouse,key
set report=0
set fillchars=vert:\ ,stl:\ ,stlnc:\
set showmatch
set matchtime=1
set scrolloff=3
set smartindent
au BufRead,BufNewFile * setfiletype txt

:imap jj <ESC>
:nnoremap <C-J> <C-W><C-J>
:nnoremap <C-K> <C-W><C-K>
:nnoremap <C-L> <C-W><C-L>
:nnoremap <C-H> <C-W><C-H>
 
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on
set completeopt=longest,menu


