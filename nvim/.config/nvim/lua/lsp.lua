vim.api.nvim_create_augroup('lsp_attach', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'lsp_attach',
    once = true,
    callback = function()
        -- vim.keymap.set('n', '<space>', vim.lsp.buf.hover, { silent = true })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
        vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>', { silent = true })
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { silent = true })

        -- vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { silent = true })
        -- vim.keymap.set('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
        -- vim.keymap.set('n', '<C-n>', vim.lsp.buf.code_action, { silent = true })
        --
        if vim.bo.filetype == "markdown" then
            vim.keymap.set('v', '<leader>lf', ':!prettier --parser markdown<CR>', { silent = true })
        else
            vim.keymap.set('v', '<leader>lf', vim.lsp.buf.format, { silent = true })
        end

        -- LSP hover/signature popups render as markdown; without this the ``` fence
        -- lines stay visible and j/k can land the cursor on them. Force conceal on
        -- the current line and make j/k step over fence lines instead of onto them.
        local orig_floating_preview = vim.lsp.util.open_floating_preview
        vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
            local buf, win = orig_floating_preview(contents, syntax, opts, ...)
            vim.wo[win].concealcursor = 'n'

            local function is_fence(row)
                local ok, node = pcall(vim.treesitter.get_node, { bufnr = buf, pos = { row - 1, 0 } })
                if ok and node then
                    return node:type() == 'fenced_code_block_delimiter'
                end
                return vim.fn.synconcealed(row, 1)[1] == 1
            end

            local function move(step)
                return function()
                    local last = vim.api.nvim_buf_line_count(buf)
                    local row = vim.api.nvim_win_get_cursor(win)[1]
                    for _ = 1, vim.v.count1 do
                        repeat
                            row = math.max(1, math.min(last, row + step))
                        until row == 1 or row == last or not is_fence(row)
                    end
                    vim.api.nvim_win_set_cursor(win, { row, 0 })
                end
            end

            vim.keymap.set('n', 'j', move(1),  { buffer = buf, silent = true })
            vim.keymap.set('n', 'k', move(-1), { buffer = buf, silent = true })

            return buf, win
        end
    end
})
