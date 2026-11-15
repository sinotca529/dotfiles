-- Treat huge files as filetype "bigfile" so that everything keyed on the real
-- filetype (treesitter, LSP, ftplugins) never attaches. Same approach as
-- snacks.nvim's bigfile module, without pulling in the whole plugin.
-- Plugins that react to other events must skip "bigfile" themselves
-- (see statusline.lua and plugin/indentmini.lua).
-- To get the full features back for a buffer: `:set filetype=<real ft>`.

local max_size = 1.5 * 1024 * 1024 -- bytes
local max_avg_line_length = 1000    -- catches minified files below max_size

vim.filetype.add({
    pattern = {
        ['.*'] = {
            function(path, buf)
                if not path or not buf or vim.bo[buf].filetype == 'bigfile' then
                    return
                end
                local size = vim.fn.getfsize(path)
                if size <= 0 then
                    return
                end
                if size > max_size then
                    return 'bigfile'
                end
                local lines = vim.api.nvim_buf_line_count(buf)
                if (size - lines) / lines > max_avg_line_length then
                    return 'bigfile'
                end
            end,
            -- run before every other pattern so it wins over the real filetype
            { priority = math.huge },
        },
    },
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('bigfile', {}),
    pattern = 'bigfile',
    callback = function(ev)
        local real_ft = vim.filetype.match({ buf = ev.buf }) or ''
        vim.api.nvim_buf_call(ev.buf, function()
            vim.opt_local.foldmethod = 'manual'
            vim.opt_local.undolevels = 100
        end)
        -- cheap regex highlighting is still fine ('synmaxcol' / 'redrawtime' cap it)
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) then
                vim.bo[ev.buf].syntax = real_ft
            end
        end)
        -- keep it short: a message that wraps triggers a "Press ENTER" prompt
        vim.notify(('bigfile: TS/LSP off (:set ft=%s)'):format(real_ft), vim.log.levels.WARN)
    end,
})
