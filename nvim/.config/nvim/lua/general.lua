vim.o.virtualedit = 'onemore,block'
vim.o.whichwrap = 'h,l'
vim.o.fenc = 'utf-8'
vim.o.mouse = ''
vim.o.laststatus = 3
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 8
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.winblend = 10
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.fileformats = 'unix,dos,mac'
vim.o.wrap = false
vim.o.nf = 'alpha,octal,hex,bin,unsigned'
vim.g.mapleader = ' '
vim.o.signcolumn = 'yes:2'
vim.o.background = 'dark'
vim.o.cinoptions = 'l1'

-- effects on CursorHold, CursorHoldI (do not set to above 500)
vim.o.ut = 200
vim.api.nvim_create_augroup('ut', {})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'ut',
    once = true,
    callback = function() vim.o.ut = 4000 end
})

vim.o.clipboard = 'unnamedplus'
if vim.fn.executable('win32yank.exe') == 1 then
    vim.g.clipboard = {
        name = 'wslClipboard',
        copy = {
            ['+'] = 'win32yank.exe -i',
            ['*'] = 'win32yank.exe -i',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
    }
end

if vim.fn.executable('sway') == 1 then
    vim.o.clipboard = 'unnamedplus'
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_exec([[:%s/\s\+$//ge]], false)
    end,
})
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = { '*' },
    callback = function() vim.cmd.cle() end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.ll',
    callback = function() vim.cmd.setfiletype('llvm') end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.tex',
    callback = function() vim.cmd.setfiletype('tex') end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.h.inc',
    callback = function() vim.cmd.setfiletype('cpp') end,
})

---------------------------
-- disable_default_plugins
---------------------------
-- menu
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1

vim.g.loaded_syntax_completion  = 1 -- native syntax completion
vim.g.loaded_spellfile_plugin   = 1 -- spell files
vim.g.loaded_2html_plugin       = 1 -- convert buf to html

-- related to checking files inside compressed files
vim.g.loaded_gzip               = 1
vim.g.loaded_tar                = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_vimball            = 1
vim.g.loaded_vimballPlugin      = 1
vim.g.loaded_zip                = 1
vim.g.loaded_zipPlugin          = 1

vim.g.loaded_sql_completion     = 1 -- sql omni completion
vim.g.loaded_tutor_mode_plugin  = 1 -- tutor

vim.g.loaded_netrw              = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_remote_plugins     = 1
vim.g.skip_loading_mswin        = 1
-- vim.g.did_indent_on = 1
-- vim.g.did_laod_filetypes = 1
-- vim.g.loaded_shada_plugin       = 1
-- vim.g.did_load_ftplugin         = 1
-- vim.g.loaded_man                = 1
-- vim.g.loaded_matchit            = 1
-- vim.g.loaded_matchparen         = 1

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn',  { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo',  { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint',  { text = '', texthl = 'DiagnosticSignHint' })

-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
    notify(msg, ...)
end
