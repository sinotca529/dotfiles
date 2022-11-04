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

-- push_plugin(require('plugin.adjust-indent')) -- plugin/adjust-indent.lua

return require('packer').startup(function(use)
    use({'wbthomason/packer.nvim'})

    require('plugin.appearance')(use)
    require('plugin.support-coding')(use)
    require('plugin.gitsigns')(use)
    require('plugin.tool')(use)

    if packer_bootstrap then
        require('packer').sync()
    end
end)
