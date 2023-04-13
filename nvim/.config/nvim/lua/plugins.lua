local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
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
