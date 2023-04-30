vim.o.number = true
vim.o.virtualedit = 'onemore,block'
vim.o.whichwrap = 'h,l'
vim.o.fenc = 'utf-8'
vim.o.mouse = 'a'
vim.o.laststatus = 3
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.winblend = 10
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.fileformats = 'unix,dos,mac'
vim.o.wrap = false
vim.o.nf = 'alpha,octal,hex,bin,unsigned'
vim.g.mapleader = ','

vim.o.clipboard = 'unnamedplus'
if vim.fn.has("wsl") then
    vim.g.clipboard = {
        name = 'wslClipboard',
        copy = {
            ['+'] = 'win32yank.exe -i',
            ['*'] = 'win32yank.exe -i',
        },
        paste = {
            ['+'] = 'win32yank.exe -o',
            ['*'] = 'win32yank.exe -o',
        },
    }
end
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {'*'},
    callback = function()
        vim.api.nvim_exec([[:%s/\s\+$//ge]], false)
    end,
})

local disable_default_plugins = function()
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

    -- vim.g.did_indent_on = 1
    -- vim.g.did_laod_filetypes = 1
    -- vim.g.loaded_shada_plugin       = 1
    -- vim.g.did_load_ftplugin         = 1
    -- vim.g.loaded_man                = 1
    -- vim.g.loaded_matchit            = 1
    -- vim.g.loaded_matchparen         = 1
    -- vim.g.loaded_netrwPlugin        = 1
    -- vim.g.loaded_remote_plugins     = 1
    -- vim.g.skip_loading_mswin        = 1
end

disable_default_plugins()
