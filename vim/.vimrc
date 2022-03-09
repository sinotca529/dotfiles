" Plugins
call plug#begin()
    Plug 'tomasiser/vim-code-dark'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
call plug#end()

"call plug#begin()
"    Plug 'prabirshrestha/vim-lsp', { 'on': [] }
"    Plug 'mattn/vim-lsp-settings', { 'on': [] }
"call plug#end()
"
"function! s:LoadPlugsLazy(timer)
"    echom "HERE"
"    " plug#loadはバッファをリロードするため，現在位置をZにマーキング．
"    " normal! mZ
"    call plug#load(
"        \ 'vim-lsp',
"        \ 'vim-lsp-settings',
"    \ )
"    " normal! g`Z
"    " delmarks Z
"    echom "END"
"endfunction
"call timer_start(500, function("s:LoadPlugsLazy"))
"

so ~/dotfiles/vim/.vim/rc/vim-lsp.vim
so ~/dotfiles/vim/.vim/rc/general.vim
so ~/dotfiles/vim/.vim/rc/keybind.vim

"-------------
" Status line
"-------------

" モード名の取得
function! ModeName()
    let l:mode = mode()
    if l:mode =~ 'i'
        return 'INSERT'
    elseif l:mode =~ 'n'
        return 'NORMAL'
    elseif l:mode =~ 'R'
        return 'REPLACE'
    elseif l:mode =~ 's'
        return 'SELECT'
    elseif l:mode =~ 'S'
        return 'SELECT'
    else
        return 'VISUAL'
    endif
endfunction


" hi User1 guibg=#16825d guifg=white
hi User1 guibg=#16825d guifg=white gui=undercurl guisp=#ff0000
hi User2 guibg=#68217a ctermfg=white

" モード名
set statusline=%1*\ %{ModeName()}
set statusline+=\ %*

set statusline+=%2*

" ファイル名 (相対パス)
set statusline+=\ %f
" 変更チェック
set statusline+=%m
" 読み込み専用か
set statusline+=%r
" 以降は右寄せ
set statusline+=%=
" タブ
set statusline+=space:%{&tabstop}
" エンコード
set statusline+=\ %{&fileencoding}
" 改行コード
let dict_line = {
\    'dos': 'CR+LF',
\    'unix': 'LF',
\    'mac': 'CR'
\}
set statusline+=\ %{dict_line[&fileformat]}

set statusline+=\ %*

