" rc for vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=no
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gi <Plug>(lsp-implementation)
    "nmap <buffer> <Space> <Plug>(lsp-hover)
    nmap <buffer> <f2> <plug>(lsp-rename)
    "nmap <buffer> <Plug>(lsp-document-diagnostic)

    hi LspError guibg=#a25768 guifg=#ffffff
    hi LspWarn  guibg=#928c36 guifg=#ffffff

    hi link LspErrorHighlight LspError
    hi link LspWarningHighlight LspWarn
    hi link LspInformationHighlight Error
    hi link LspHintHighlight Error

    " リアルタイムにエラーを表示
    let g:lsp_diagnostics_enabled = 1
    " 入力補完ポップアップを自動で表示
    let g:asyncomplete_auto_popup = 1
    let g:asyncomplete_auto_completeopt = 0
    " ポップアップ表示までのディレイ
    let g:asyncomplete_popup_delay = 200
    " エラー等の表示を左に出さない
    let g:lsp_diagnostics_signs_enabled = 0
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

set wildmenu
set wildmode=full


