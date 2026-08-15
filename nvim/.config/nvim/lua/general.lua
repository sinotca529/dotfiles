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
vim.o.winborder = 'rounded'

-- effects on CursorHold, CursorHoldI (do not set to above 500)
vim.o.ut = 200
vim.api.nvim_create_augroup('ut', {})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'ut',
    once = true,
    callback = function() vim.o.ut = 4000 end
})

vim.o.clipboard = 'unnamedplus'
-- executable() searches all of $PATH, including the Windows side under WSL2,
-- which is slow over the 9P interop layer (tens of ms). Defer it off the
-- synchronous startup path; it still resolves before any user input happens.
vim.schedule(function()
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
end)

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_exec2([[:%s/\s\+$//ge]], {})
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

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
    notify(msg, ...)
end

-- Fix icon width for Nerd Fonts v3.2.1 (verified against todo-comments.nvim).
-- Source: https://github.com/folke/todo-comments.nvim/issues/282#issuecomment-2246289126
vim.fn.setcellwidths {
    { 0x23fb, 0x23fe, 2 },   -- IEC Power Symbols
    { 0x2665, 0x2665, 2 },   -- Octicons
    { 0x2b58, 0x2b58, 2 },   -- IEC Power Symbols
    { 0xe000, 0xe00a, 2 },   -- Pomicons
    { 0xe0b8, 0xe0c8, 2 },   -- Powerline Extra
    { 0xe0ca, 0xe0ca, 2 },   -- Powerline Extra
    { 0xe0cc, 0xe0d7, 2 },   -- Powerline Extra
    { 0xe200, 0xe2a9, 2 },   -- Font Awesome Extension
    { 0xe300, 0xe3e3, 2 },   -- Weather Icons
    { 0xe5fa, 0xe6b5, 2 },   -- Seti-UI + Custom
    { 0xe700, 0xe7c5, 2 },   -- Devicons
    { 0xea60, 0xec1e, 2 },   -- Codicons
    { 0xed00, 0xefce, 2 },   -- Font Awesome
    { 0xf000, 0xf2ff, 2 },   -- Font Awesome
    { 0xf300, 0xf375, 2 },   -- Font Logos
    { 0xf400, 0xf533, 2 },   -- Octicons
    { 0xf0001, 0xf1af0, 2 }, -- Material Design
}
