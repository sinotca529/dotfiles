local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
}

local word_count = {
    'wordcount',
    fmt = function()
        local selected = ''
        if vim.fn.mode():find('[vV]') then
            selected = tostring(vim.fn.wordcount().visual_chars) .. '/'
        end
        return selected .. tostring(vim.fn.wordcount().chars) .. ' chars'
    end,
    icons_enabled = false,
}

local encoding = { 'o:encoding', fmt = string.upper, }

local file_format = {
    'fileformat',
    fmt = function(type)
        if type == 'unix' then
            return 'LF'
        elseif type == 'mac' then
            return 'CR'
        elseif type == 'dos' then
            return 'CRLF'
        else
            return '??'
        end
    end,
    icons_enabled = false,
}

local shift_width = {
    'shiftwidth',
    fmt = function(width)
        if vim.opt_local.expandtab:get() then
            return 'SP' .. width
        else
            return 'TAB'
        end
    end,
    icons_enabled = false,
}

return {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                component_separators = '',
                section_separators = '',
            },
            sections = {
                lualine_b = {},
                lualine_c = { 'filename', 'location', diagnostics },
                lualine_x = { word_count, encoding, file_format, shift_width, 'branch' },
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        })
    end
}
