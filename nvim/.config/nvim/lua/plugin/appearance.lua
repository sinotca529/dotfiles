local function color_scheme()
    return {
        'sainnhe/gruvbox-material',
        lazy = false,
        config = function()
            vim.cmd('colorscheme gruvbox-material')
            vim.cmd('hi Comment cterm=NONE')
            vim.cmd('hi Comment gui=NONE')
            vim.cmd('hi Normal ctermbg=NONE guibg=#NONE')
            -- vim.cmd('hi NormalNC ctermbg=NONE guibg=#NONE')
            vim.cmd('hi NonText ctermbg=NONE guibg=#NONE')
            vim.cmd('hi LineNr ctermbg=NONE guibg=#NONE')
            vim.cmd('hi Folded ctermbg=NONE guibg=#NONE')
            vim.cmd('hi EndOfBuffer ctermbg=NONE guibg=#NONE')
        end
    }
end

-- インデント幅毎に縦線を表示
local function indent_blankline()
    return {
        'lukas-reineke/indent-blankline.nvim',
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = function()
            require('indent_blankline').setup({})
        end
    }
end

local function tree_sitter()
    return {
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        event = { "CursorHold", "CursorHoldI" },
        -- event = { "BufReadPost" },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'c', 'cpp', 'llvm', 'rust',
                    'lua', 'python',
                    'markdown', 'markdown_inline',
                    'latex',
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = {},
                }
            })
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        end
    }
end

local function lualine()
  return {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {'kyazdani42/nvim-web-devicons'},
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
            'o:encoding', -- option component same as &encoding in viml
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_right {
            'fileformat',
            fmt = function(type)
                if     type == 'unix' then return 'LF'
                elseif type == 'mac' then return 'CR'
                elseif type == 'dos' then return 'CR+LF'
                else   return '??'
                end
            end,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }
        ins_right {
            'shiftwidth',
            fmt = function(width)
              if vim.opt_local.expandtab:get() then
                return 'SP'..width
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
end

return function(plugins)
    plugins[#plugins+1] = color_scheme()
    plugins[#plugins+1] = indent_blankline()
    plugins[#plugins+1] = tree_sitter()
    plugins[#plugins+1] = lualine()
end
