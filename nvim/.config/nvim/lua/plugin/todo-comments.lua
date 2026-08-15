return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'CursorHold', 'CursorHoldI' },
    opts = {
        signs = false,
        keywords = {
            FIX = { icon = "o", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = "o", color = "info" },
            HACK = { icon = "o", color = "warning" },
            WARN = { icon = "o", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = "o", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = "o", color = "hint", alt = { "INFO" } },
            TEST = { icon = "o", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        }
    }
}
