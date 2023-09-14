set number
set virtualedit=onemore,block
set whichwrap=h,l
set fenc=utf-8
set laststatus=3
set expandtab
set shiftwidth=4
set tabstop=4
set breakindent
set foldmethod=indent
set foldlevel=99
set nowrap
set nf=alpha,octal,hex,bin,unsigned
set visualbell t_vb=
set autoindent
set smartindent
set hlsearch
set completeopt=menuone,noinsert
set bs=indent,eol,start

syntax enable
colorscheme elflord

autocmd BufWritePre * :%s/\s\+$//ge

inoremap <silent> jj <ESC>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
