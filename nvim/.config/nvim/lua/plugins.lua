local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazy_repo = 'https://github.com/folke/lazy.nvim.git '
    vim.api.nvim_command('!git clone --filter=blob:none --branch=stable ' .. lazy_repo .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

local plugins = {}
require('plugin.appearance')(plugins) -- lua/plugin/appearance.lua
require('plugin.support-coding')(plugins) -- lua/plugin/support-coding.lua
require('plugin.git')(plugins) -- lua/plugin/git.lua
require('plugin.tool')(plugins) -- lua/plugin/tool.lua
require('plugin.tex')(plugins) -- lua/plugin/tex.lua
require('plugin.debug')(plugins) -- lua/plugin/debug.lua

require('lazy').setup(plugins)
