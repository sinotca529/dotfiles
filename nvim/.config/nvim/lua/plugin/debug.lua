local dap = {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
        require('dapui').setup({
            icons = { expanded = '', collapsed = '', current_frame = '' },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { '<CR>' },
                open = 'o',
                remove = 'd',
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
                -- Example:
                -- stacks = {
                --   open = '<CR>',
                --   expand = 'o',
                -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has('nvim-0.7') == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be 'left', 'right', 'top' or 'bottom'.
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                    -- Elements can be strings or table with id and size keys.
                        { id = 'scopes', size = 0.25 },
                        'breakpoints',
                        'stacks',
                        'watches',
                    },
                    size = 40, -- 40 columns
                    position = 'left',
                },
                {
                    elements = {
                        'repl',
                        'console',
                    },
                    size = 0.25, -- 25% of total lines
                    position = 'bottom',
                },
            },
            controls = {
                -- Requires Neovim nightly (or 0.8 when released)
                enabled = true,
                -- Display controls in this element
                element = 'repl',
                icons = {
                    pause = '',
                    play = '',
                    step_into = '',
                    step_over = '',
                    step_out = '',
                    step_back = '',
                    run_last = '',
                    terminate = '',
                },
            },
            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            }
        })
        vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>db', ':DapToggleBreakpoint<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dB', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint cond: "))<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dlp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
        vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require("dapui").toggle()<CR>', {})
    end
}

local nvim_dap_lsp = {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
        'mfussenegger/nvim-dap',
        'williamboman/mason.nvim',
        'mfussenegger/nvim-dap'
    },
    config = function()
        require('mason-nvim-dap').setup({
            ensure_installed = { 'cppdbg' },
            handlers = {
                function(conf)
                    require('mason-nvim-dap').default_setup(conf)
                end,
            },
        })
    end
}

local python = {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui' },
    config = function()
        require('dap-python').setup('/usr/bin/python3')
    end
}

return function(plugins)
    plugins[#plugins+1] = dap
    -- plugins[#plugins+1] = python
    plugins[#plugins+1] = nvim_dap_lsp
end
