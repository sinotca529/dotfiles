-- Pin the enclosing function / block headers at the top of the window.

-- The context floats inherit the global 'winblend' (general.lua), which lets
-- the text underneath show through the gaps between words. Make them opaque.
local function make_context_opaque()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.w[win].treesitter_context or vim.w[win].treesitter_context_line_number then
            vim.wo[win].winblend = 0
        end
    end
end

return {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
        max_lines = 3, -- at most 3 pinned lines
    },
    config = function(_, opts)
        require('treesitter-context').setup(opts)
        -- same events the plugin redraws on; registered after it, so this
        -- scheduled callback runs right after the plugin's own scheduled render
        vim.api.nvim_create_autocmd({ 'WinScrolled', 'BufEnter', 'WinEnter', 'CursorMoved', 'WinResized' }, {
            group = vim.api.nvim_create_augroup('treesitter_context_opaque', {}),
            callback = function() vim.schedule(make_context_opaque) end,
        })
    end,
}
