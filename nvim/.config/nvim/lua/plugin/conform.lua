-- Formatting entry point: <leader>lf in normal (whole buffer) and visual
-- (selection) mode. Filetypes without a formatter listed here fall back to
-- the attached LSP server's formatting.
-- djot keeps its own buffer-local <leader>lf (plugin/nvim-treesitter.lua).
return {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    keys = {
        { '<leader>lf', function() require('conform').format() end, mode = { 'n', 'x' }, desc = 'format' },
    },
    opts = {
        formatters_by_ft = {
            markdown = { 'prettier_markdown' },
        },
        formatters = {
            -- prettier's own --range-start/--range-end does nothing for
            -- markdown, so define it without range_args: conform then formats
            -- the whole buffer and keeps only the diffs inside the selection.
            prettier_markdown = {
                command = 'prettier',
                args = { '--stdin-filepath', '$FILENAME' },
                stdin = true,
            },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
    },
}
