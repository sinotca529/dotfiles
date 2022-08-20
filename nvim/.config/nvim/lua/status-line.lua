function _G.mode_name_str()
    local mode = vim.fn.mode()
    if     mode == 'i' then return 'INSERT '
    elseif mode == 'n' then return 'NORMAL '
    elseif mode == 'R' then return 'REPLASE'
    elseif mode == 's' then return 'SELECT '
    elseif mode == 'S' then return 'SELECT '
    else                    return 'VISUAL '
    end
end

vim.g.dict_line = {
    dos  = 'CR+LF',
    unix = 'LF',
    mac  = 'CR',
}

vim.cmd('hi User1 guibg=#16825d ctermfg=white')
vim.cmd('hi User2 guibg=#68217a ctermfg=white')
vim.o.statusline =
       [[%1* %{v:lua.mode_name_str()} %*]]
       -- File path, is modified?, is readonly?
    .. [[%2* %f%m%r]]
       -- Align right
    .. [[%=]]
    .. [[space:%{&tabstop}]]
    .. [[ %{&fileencoding}]]
    .. [[ %{dict_line[&fileformat]}]]

