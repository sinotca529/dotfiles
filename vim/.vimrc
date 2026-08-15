"----------------------------------------------------------------------
" 1. 基本オプション
"----------------------------------------------------------------------
set runtimepath+=~/works/vim-todo
set virtualedit=onemore,block
set whichwrap=h,l
set fenc=utf-8
set mouse=
set laststatus=2
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
set noshowmode
let g:mapleader="\<Space>"

"----------------------------------------------------------------------
" 2. 高速化・その他の最適化
"----------------------------------------------------------------------
" effects on CursorHold, CursorHoldI (do not set to above 500)
set updatetime=200
augroup ut
  autocmd!
  autocmd CursorHold,CursorHoldI * ++once let &updatetime = 4000
augroup END

" Fix icon width for Nerd Fonts v3.2.1 (verified against todo-comments.nvim).
" Source: https://github.com/folke/todo-comments.nvim/issues/282#issuecomment-2246289126
if exists('*setcellwidths')
  call setcellwidths([
    \ [0x23fb, 0x23fe, 2],
    \ [0x2665, 0x2665, 2],
    \ [0x2b58, 0x2b58, 2],
    \ [0xe000, 0xe00a, 2],
    \ [0xe0b8, 0xe0c8, 2],
    \ [0xe0ca, 0xe0ca, 2],
    \ [0xe0cc, 0xe0d7, 2],
    \ [0xe200, 0xe2a9, 2],
    \ [0xe300, 0xe3e3, 2],
    \ [0xe5fa, 0xe6b5, 2],
    \ [0xe700, 0xe7c5, 2],
    \ [0xea60, 0xec1e, 2],
    \ [0xed00, 0xefce, 2],
    \ [0xf000, 0xf2ff, 2],
    \ [0xf300, 0xf375, 2],
    \ [0xf400, 0xf533, 2],
    \ [0xf0001, 0xf1af0, 2],
    \ ])
endif

"----------------------------------------------------------------------
" 3. 配色
"----------------------------------------------------------------------
syntax enable
colorscheme elflord

"----------------------------------------------------------------------
" 4. 自動コマンド(プラグインに依存しないもの)
"----------------------------------------------------------------------
autocmd BufWritePre * let s:save = winsaveview() | %s/\s\+$//e | call winrestview(s:save)

"----------------------------------------------------------------------
" 5. キーマップ(基本操作)
"----------------------------------------------------------------------
" Swap (j, gj), (k, gk)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

inoremap jj <ESC>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap <C-q> <Nop>

nnoremap Y y$

" Toggle word wrap
nnoremap <silent> <M-z> :set wrap!<CR>

onoremap i<space> iW
xnoremap i<space> iW

" 行の入れ替え
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv-gv
vnoremap <C-k> :m '<-2<CR>gv-gv

" ウィンドウ操作
nnoremap s <C-W>

"----------------------------------------------------------------------
" 6. プラグイン管理(NeoBundle)
"   mkdir ~/.vim/bundle
"   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"----------------------------------------------------------------------

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
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'rhysd/conflict-marker.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'lambdalisue/fern.vim'
NeoBundle 'lambdalisue/fern-git-status.vim'
NeoBundle 'lambdalisue/nerdfont.vim'
NeoBundle 'lambdalisue/fern-renderer-nerdfont.vim'
NeoBundle 'lambdalisue/fern-hijack.vim'
NeoBundle 'iamcco/markdown-preview.nvim'
NeoBundle 'mattn/vim-maketable'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'alvan/vim-closetag'
NeoBundle 'liuchengxu/vim-which-key'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'mattn/vim-lsp-settings'
NeoBundle 'prabirshrestha/asyncomplete.vim'
NeoBundle 'prabirshrestha/asyncomplete-lsp.vim'
NeoBundle 'voldikss/vim-floaterm'
NeoBundle 'sinotca529/aichat.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"----------------------------------------------------------------------
" 7. プラグイン別設定
"----------------------------------------------------------------------

" --- vim-easymotion: 画面内ジャンプ移動 ---
map <Leader> <Plug>(easymotion-prefix)

" --- indentLine: インデントの深さをガイド線で表示 ---
let g:indentLine_char = '│'

" --- vim-gitgutter / vim-fugitive: git差分のガター表示・hunk操作・blame ---
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gh :GitGutterPreviewHunk<CR>
nnoremap <Leader>gr :GitGutterUndoHunk<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>

" --- conflict-marker.vim: マージコンフリクトの解消支援 ---
" 既定のキーマップ(co/ct/cb/cn, ]x/[x)を使うため追加設定なし

" --- fzf.vim: ファイル/grep/バッファのあいまい検索 ---
if executable('fd')
  let $FZF_DEFAULT_COMMAND = "fd --type f --type l --follow --exclude .git"
        \ . " --exclude '*.a' --exclude '*.o' --exclude '*.so' --exclude '*.out' --exclude '*.class'"
endif
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :Rg<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>

" --- vim-which-key: 押した後に一呼吸置くとキーマップ候補をポップアップ表示 ---
" <Leader>単体は既にeasymotionのprefixのため、グループ単位(f/g)でWhichKeyを起動する
set timeoutlen=300
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+fzf-lua' }
let g:which_key_map.g = { 'name': '+git' }
if exists('*which_key#register')
  call which_key#register('<Space>', 'g:which_key_map')
endif
nnoremap <silent> <Leader>f :<C-u>WhichKey '<Space>f'<CR>
nnoremap <silent> <Leader>g :<C-u>WhichKey '<Space>g'<CR>

" --- vim-closetag: HTMLタグを閉じると自動で終了タグを補完 ---
" html以外では誤爆しやすいため対象filetypeをhtmlのみに絞る
let g:closetag_filetypes = 'html'

" --- markdown-preview.nvim: Markdownをブラウザでプレビュー ---
" vim-maketable: Markdownの表を整形(追加設定不要)
if exists('*mkdp#util#install')
  call mkdp#util#install()
endif
let g:mkdp_preview_options = { 'disable_sync_scroll': 1 }
nnoremap <Leader>mt <Plug>MarkdownPreviewToggle

" --- fern.vim: ファイルツリーをドロワー(サイドバー)表示 ---
let g:fern#default_hidden = 1
let g:fern#renderer = 'nerdfont'
" 既定マッピングは<C-h>を「親ディレクトリへ移動」に使うなど競合するため無効化し、必要な分だけ自前で定義する
let g:fern#disable_default_mappings = 1
nnoremap <silent> <C-h> :Fern . -drawer -toggle -width=40<CR>

augroup fern_keymap
  autocmd!
  " 開いた状態のディレクトリでEnterを押すと畳む(トグル)。展開時にカーソルは子要素へ移動させない
  autocmd FileType fern nmap <buffer><expr> <CR> fern#smart#leaf(
        \ "\<Plug>(fern-action-open)",
        \ "\<Plug>(fern-action-expand:stay)",
        \ "\<Plug>(fern-action-collapse)")
  autocmd FileType fern nmap <buffer> l    <Plug>(fern-action-expand:stay)
  autocmd FileType fern nmap <buffer> h    <Plug>(fern-action-collapse)
  autocmd FileType fern nmap <buffer> a    <Plug>(fern-action-new-file)
  autocmd FileType fern nmap <buffer> d    <Plug>(fern-action-remove)
  autocmd FileType fern nmap <buffer> <C-r> <Plug>(fern-action-rename)
  autocmd FileType fern nmap <buffer> x    <Plug>(fern-action-mark)
  autocmd FileType fern nmap <buffer> p    <Plug>(fern-action-move)
augroup END

" netrwを無効化し、fern-hijack.vimに`vim <dir>`/`:e <dir>`等の乗っ取りを任せる
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" --- コメント内のTODO/FIXME等のキーワードを色分けハイライト ---
augroup todo_highlight
  autocmd!
  autocmd Syntax * syntax match TodoFIX  /\v<(FIX|FIXME|BUG|FIXIT|ISSUE)>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoTODO /\v<TODO>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoHACK /\v<HACK>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoWARN /\v<(WARN|WARNING|XXX)>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoPERF /\v<(PERF|OPTIM|PERFORMANCE|OPTIMIZE)>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoNOTE /\v<(NOTE|INFO)>/ containedin=.*Comment.*
  autocmd Syntax * syntax match TodoTEST /\v<(TEST|TESTING|PASSED|FAILED)>/ containedin=.*Comment.*
augroup END

highlight TodoFIX  guifg=#282c34 guibg=#e06c75 gui=bold
highlight TodoTODO guifg=#282c34 guibg=#61afef gui=bold
highlight TodoHACK guifg=#282c34 guibg=#e5c07b gui=bold
highlight TodoWARN guifg=#282c34 guibg=#e5c07b gui=bold
highlight TodoPERF guifg=#282c34 guibg=#c678dd gui=bold
highlight TodoNOTE guifg=#282c34 guibg=#56b6c2 gui=bold
highlight TodoTEST guifg=#282c34 guibg=#98c379 gui=bold

" --- lightline.vim: ステータスライン(モード/ファイル名/git branch/文字数等を表示) ---
function! LightlineFileformat() abort
  if &fileformat ==# 'unix'
    return 'LF'
  elseif &fileformat ==# 'mac'
    return 'CR'
  elseif &fileformat ==# 'dos'
    return 'CRLF'
  else
    return '??'
  endif
endfunction

function! LightlineShiftwidth() abort
  return &expandtab ? 'SP' . &shiftwidth : 'TAB'
endfunction

function! LightlineWordcount() abort
  let l:wc = wordcount()
  if mode() =~# "[vV\<C-v>]"
    return get(l:wc, 'visual_chars', 0) . '/' . l:wc.chars . ' chars'
  endif
  return l:wc.chars . ' chars'
endfunction

function! s:UpdateGitBranch() abort
  let l:dir = expand('%:p:h')
  if empty(l:dir) || !isdirectory(l:dir)
    let l:dir = getcwd()
  endif
  let b:git_branch = trim(system('git -C ' . shellescape(l:dir) . ' rev-parse --abbrev-ref HEAD 2>/dev/null'))
  if v:shell_error
    let b:git_branch = ''
  endif
endfunction

augroup lightline_git_branch
  autocmd!
  autocmd BufEnter,BufWritePost * call s:UpdateGitBranch()
augroup END

function! LightlineBranch() abort
  return get(b:, 'git_branch', '')
endfunction

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'filename', 'lineinfo' ] ],
  \   'right': [ [ 'branch', 'wordcount', 'fileformat', 'fileencoding', 'shiftwidth' ] ],
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [] ],
  \ },
  \ 'component_function': {
  \   'fileformat': 'LightlineFileformat',
  \   'shiftwidth': 'LightlineShiftwidth',
  \   'wordcount': 'LightlineWordcount',
  \   'branch': 'LightlineBranch',
  \ },
  \ }

" --- vim-lsp / vim-lsp-settings / asyncomplete.vim: LSPによる定義ジャンプ・補完・診断・フォーマット ---
" 現在行の診断をカーソル位置に自動フロート表示する
let g:lsp_diagnostics_float_cursor = 1

" コードアクションが利用可能な行にsigncolumnへ'A>'を表示する機能を無効化
let g:lsp_document_code_action_signs_enabled = 0

" lua-language-serverのみ、未定義グローバル`vim`の警告を抑制する(nvim側の lua_ls 設定を踏襲)
let g:lsp_settings = {
  \ 'sumneko-lua-language-server': {
  \   'workspace_config': {
  \     'Lua': {
  \       'diagnostics': {
  \         'globals': ['vim'],
  \       },
  \     },
  \   },
  \ },
  \ }

function! s:on_lsp_buffer_enabled() abort
  nnoremap <buffer> gd :LspDefinition<CR>
  nnoremap <buffer> K :LspHover<CR>
  nnoremap <buffer> gi :LspImplementation<CR>
  nnoremap <buffer> ge :LspDocumentDiagnostics<CR>
  nnoremap <buffer> <C-.> :LspCodeAction<CR>
  " fzf-luaのlsp_finder(定義/参照/実装の統合検索)相当。vim-lspに単一の統合コマンドはないため参照検索で代替
  nnoremap <buffer> <Leader>lsf :LspReferences<CR>
  nnoremap <buffer> <Leader>lf :LspDocumentFormatSync<CR>
  if &filetype ==# 'markdown'
    vnoremap <buffer> <Leader>lf :!prettier --parser markdown<CR>
  else
    vnoremap <buffer> <Leader>lf :LspDocumentRangeFormatSync<CR>
  endif
endfunction

augroup lsp_keymap
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" --- vim-floaterm: フローティングターミナルのトグル表示 ---
" 'termwinkey'の既定値はCtrl-Wで、ターミナル内でCtrl-Wを押すたびに
" シェルへ渡らずVimの端末コマンドとして横取りされてしまう(単語削除ができない)。
" ウィンドウ切り替えは既に's'を使っているためCtrl-Wに頼る必要はなく、
" シェルの操作と衝突しないキーへ変更する。
" 'termwinkey'はウィンドウローカルオプションで、popupのような新規ウィンドウには
" グローバル設定が伝播しない。floatermは非表示(hidden:1)でterminalを作ってから
" popup_create()で後付けするため標準のTerminalWinOpenも発火しない。
" floaterm独自のUser FloatermOpen(popupを開いた直後に発火)で都度当てる
set termwinkey=<F2>
augroup terminal_local_opts
  autocmd!
  autocmd TerminalWinOpen * setlocal termwinkey=<F2>
  autocmd User FloatermOpen setlocal termwinkey=<F2>
augroup END
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_borderchars = '─│─│╭╮╯╰'
let g:floaterm_autoclose = 2

" 通常ウィンドウを:q/:qaした際、floatermの隠れたバッファでジョブが実行中だと
" E947で終了が拒否され、代わりにそのバッファが画面に表示されてしまう。
" 終了判定の前(QuitPre)に全floatermジョブを強制終了し、道連れで消す
augroup floaterm_quit
  autocmd!
  autocmd QuitPre * if exists(':FloatermKill') | FloatermKill! | endif
augroup END
" 端末の生入力ではCtrl+SpaceとCtrl+@は同じバイト(0x00)になり、Vimは<C-@>としてしか
" 区別できない(拡張キーボードプロトコルに対応していないため)ので<C-@>にマッピングする
nnoremap <silent> <C-@> :FloatermToggle<CR>
inoremap <silent> <C-@> <Esc>:FloatermToggle<CR>
tnoremap <silent> <C-@> <C-\><C-n>:FloatermToggle<CR>

" --- vim-todo: TODOリストの作成・トグル・同期 ---
nnoremap <silent> <Leader>tn :TodoNew<CR>
nnoremap <silent> <Leader>tt :TodoToggle<CR>
nnoremap <silent> <Leader>ts :TodoSync<CR>

" --- aichat.vim: ローカルLLMとのチャット ---
let g:aichat_api_url = 'http://localhost:8888/v1'
let g:aichat_model = ''
let g:aichat_save_dir = '~/.aichat/trees'
let g:aichat_curl_cmd = ['curl']
let g:aichat_context_window = 32768
let g:aichat_system_prompt  = 'コードブロック以外の修飾を禁止します。'
let g:aichat_tools = ['calculate', 'get_current_datetime', 'save_memory', 'fetch_page']
let g:aichat_keys = {
  \ 'new_chat': '<leader>an',
  \ 'tree': '<leader>at',
  \ }
