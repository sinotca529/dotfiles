return {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')
        local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Config
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = '',
                section_separators = '',
            },
            sections = {
                -- these are to remove the defaults
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
        }
        ins_left { 'location' }
        ins_left {
            'wordcount',
            fmt = function()
                if vim.bo.filetype ~= 'markdown' and vim.bo.filetype ~= 'text' and vim.bo.filetype ~= '' then
                    return ''
                end

                local selected = ''
                if vim.fn.mode():find('[vV]') then
                    selected = tostring(vim.fn.wordcount().visual_chars) .. '/'
                end
                return selected .. tostring(vim.fn.wordcount().chars) .. ' chars'
            end,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
        }
        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        ins_left {
            function()
                return '%='
            end,
        }

        ins_right {
            'o:encoding',       -- option component same as &encoding in viml
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_right {
            'fileformat',
            fmt = function(type)
                if type == 'unix' then
                    return 'LF'
                elseif type == 'mac' then
                    return 'CR'
                elseif type == 'dos' then
                    return 'CR+LF'
                else
                    return '??'
                end
            end,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_right {
            'shiftwidth',
            fmt = function(width)
                if vim.opt_local.expandtab:get() then
                    return 'SP' .. width
                else
                    return 'TAB'
                end
            end,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
        }
        ins_right {
            'diff',
            symbols = { added = '+', modified = '~', removed = '-' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        }

        lualine.setup(config)
    end
}
