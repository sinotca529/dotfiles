set virtualedit=onemore,block
set whichwrap=h,l
set fenc=utf-8
set mouse=
set laststatus=3
set expandtab
set shiftwidth=2
set tabstop=8
set termguicolors
set breakindent
set foldmethod=indent
set foldlevel=99
set fileformats=unix,dos,mac
set nowrap
set nf=alpha,octal,hex,bin,unsigned
set signcolumn=yes
set background=dark
set cinoptions=l1

set visualbell t_vb=
" set autoindent
" set smartindent
set hlsearch
set completeopt=menuone,noinsert
set bs=indent,eol,start
set clipboard=unnamed,unnamedplus
let g:mapleader="\<Space>"

syntax enable
colorscheme elflord

autocmd BufWritePre * :%s/\s\+$//ge

" Swap (j, gj), (k, gk)
" nnoremap j gj
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk

inoremap jj <ESC>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

nnoremap Y y$

onoremap i<space> iW
xnoremap i<space> iW

" 行の入れ替え
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv-gv
vnoremap <C-k> :m '<-2<CR>gv-gv

" ウィンドウ操作
nnoremap s <C-W>

"--------------------------------------------------------------------
" PLUGIN
"   mkdir ~/.vim/bundle
"   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"--------------------------------------------------------------------

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

map <Leader> <Plug>(easymotion-prefix)
