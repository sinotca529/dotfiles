set nocompatible
set bs=indent,eol,start

colorscheme elflord

" ベルを無効化
set visualbell t_vb=
" タブ文字そのものの表示幅 & expandtab時の入力スペース数
set tabstop=4
" 自動インデントで使うスペースの数
set shiftwidth=4
" タブキー押下時にスペースを入力
set expandtab
" 新規行開始時に適当なインデントを行う
set autoindent
" 自動で適当にインデント
set smartindent

set fenc=utf-8

" set shortmess-=S
set number
set virtualedit=onemore
" 前回の検索パターンを保持
set hlsearch
" h, lキーで行間を跨ぐ
set whichwrap=h,l
" 折り返しなし
set nowrap
" 折りたたみはインデント単位
set foldmethod=indent
set foldlevel=100

syntax enable
set mouse=a
set ttymouse=xterm2

" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

set completeopt=menuone,noinsert

" ステータスラインを常に表示
set laststatus=2
