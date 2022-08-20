local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        'git',
        'clone',
        '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    vim.cmd('packadd packer.nvim')
end

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'plugins.lua'},
    command = 'PackerSync',
})

local plugin_list = {}

local function push_plugin(plugin)
    plugin_list[#plugin_list+1] = plugin
end

push_plugin(require('plugin.colorscheme')) -- plugin/colorscheme.lua
push_plugin(require('plugin.lsp')) -- plugin/lsp.lua
push_plugin(require('plugin.sidebar')) -- plugin/sidebar.lua
push_plugin(require('plugin.fuzzy-finder')) -- plugin/fuzzy-finder.lua
push_plugin(require('plugin.toggleterm')) -- plugin/toggleterm.lua
push_plugin(require('plugin.statusline')) -- plugin/statusline.lua
push_plugin(require('plugin.blankline')) -- plugin/blankline.lua
push_plugin(require('plugin.gitsigns')) -- plugin/gitsigns

local retval = require('packer').startup(function(use)
    use({'wbthomason/packer.nvim'})

    for i = 1, #plugin_list do
        local use_arg_list = plugin_list[i].use_arg_list
        for j = 1, #use_arg_list do
            use(use_arg_list[j])
        end
    end

    if packer_bootstrap then
        require('packer').sync()
    end
end)

for i = 1, #plugin_list do
    plugin_list[i].init()
end

return retval

