---------------------------------------------------------------------------
-- highlights
---------------------------------------------------------------------------

-- ordered severity -> {icon, highlight suffix, source highlight group};
-- drives both the StatuslineDiag* highlights below and diagnostics().
local diag_severities = {
    { vim.diagnostic.severity.ERROR, '', 'Error', 'DiagnosticError' },
    { vim.diagnostic.severity.WARN, '', 'Warn', 'DiagnosticWarn' },
    { vim.diagnostic.severity.INFO, '', 'Info', 'DiagnosticInfo' },
}

-- name may be a single highlight group or a list, tried in order.
local function hl_color(name, attr, fallback)
    for _, n in ipairs(type(name) == 'table' and name or { name }) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = n, link = false })
        if ok and hl and hl[attr] then
            return string.format('#%06x', hl[attr])
        end
    end
    return fallback
end

local function set_highlights()
    -- mirrors lualine's own `auto` theme fallback (lualine/themes/auto.lua)
    -- group choices, used whenever a colorscheme has no dedicated lualine theme.
    local base_fg = hl_color('Normal', 'bg', '#1e1e1e')
    local accents = {
        Normal   = hl_color({ 'PmenuSel', 'PmenuThumb', 'TabLineSel' }, 'bg', '#61afef'),
        Insert   = hl_color({ 'String', 'MoreMsg' }, 'fg', '#98c379'),
        Visual   = hl_color({ 'Special', 'Boolean', 'Constant' }, 'fg', '#c678dd'),
        Replace  = hl_color({ 'Number', 'Type' }, 'fg', '#e06c75'),
        Command  = hl_color('Identifier', 'fg', '#e5c07b'),
        Terminal = hl_color('Identifier', 'fg', '#e5c07b'),
    }
    for name, color in pairs(accents) do
        vim.api.nvim_set_hl(0, 'StatuslineMode' .. name, { fg = base_fg, bg = color, bold = true })
    end

    local diag_bg = hl_color('StatusLine', 'bg')
    for _, d in ipairs(diag_severities) do
        local hl, src = d[3], d[4]
        vim.api.nvim_set_hl(0, 'StatuslineDiag' .. hl, { fg = hl_color(src, 'fg'), bg = diag_bg })
    end
end

---------------------------------------------------------------------------
-- components
---------------------------------------------------------------------------

local mode_groups = {
    n       = { 'NORMAL', 'Normal' },
    i       = { 'INSERT', 'Insert' },
    v       = { 'VISUAL', 'Visual' },
    V       = { 'V-LINE', 'Visual' },
    ['\22'] = { 'V-BLOCK', 'Visual' },
    s       = { 'SELECT', 'Visual' },
    S       = { 'S-LINE', 'Visual' },
    ['\19'] = { 'S-BLOCK', 'Visual' },
    c       = { 'COMMAND', 'Command' },
    r       = { 'PROMPT', 'Command' },
    ['!']   = { 'SHELL', 'Terminal' },
    t       = { 'TERMINAL', 'Terminal' },
}

local function mode()
    local m = vim.api.nvim_get_mode().mode
    local first = m:sub(1, 1)
    local entry
    if first == 'R' then
        entry = m:sub(2, 2) == 'v' and { 'V-REPLACE', 'Replace' } or { 'REPLACE', 'Replace' }
    else
        entry = mode_groups[first] or { m:upper(), 'Normal' }
    end
    return string.format('%%#StatuslineMode%s# %s %%*', entry[2], entry[1])
end

local function filename()
    local name = vim.fn.expand('%:t')
    if name == '' then
        name = '[No Name]'
    end
    if vim.bo.modified then
        name = name .. ' [+]'
    end
    if vim.bo.readonly or not vim.bo.modifiable then
        name = name .. ' [-]'
    end
    return name
end

local function location()
    return string.format('%d:%d', vim.fn.line('.'), vim.fn.virtcol('.'))
end

local function diagnostics()
    local counts = vim.diagnostic.count(0)
    local parts = {}
    for _, d in ipairs(diag_severities) do
        local severity, icon, hl = d[1], d[2], d[3]
        local n = counts[severity]
        if n and n > 0 then
            table.insert(parts, string.format('%%#StatuslineDiag%s#%s %d%%*', hl, icon, n))
        end
    end
    return table.concat(parts, ' ')
end

local function word_count()
    local wc = vim.fn.wordcount()
    if vim.fn.mode():find('[vV\22]') then
        return string.format('%d/%d chars', wc.visual_chars or 0, wc.chars)
    end
    return string.format('%d chars', wc.chars)
end

local function encoding()
    local enc = vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc
    return enc:upper()
end

local file_format_map = { unix = 'LF', mac = 'CR', dos = 'CRLF' }
local function file_format()
    return file_format_map[vim.bo.fileformat] or '??'
end

local function shift_width()
    local sw = vim.bo.shiftwidth
    if sw == 0 then
        sw = vim.bo.tabstop
    end
    if vim.bo.expandtab then
        return 'SP' .. sw
    end
    return 'TAB'
end

-- names of LSP clients attached to the current buffer; empty = no LSP running
local function lsp()
    local names = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        names[#names + 1] = client.name
    end
    return table.concat(names, ',')
end

local function branch()
    local head = vim.b.gitsigns_head
    if not head or head == '' then
        return ''
    end
    return '' .. head
end

---------------------------------------------------------------------------
-- render
---------------------------------------------------------------------------

-- concat parts with sep, skipping empty strings
local function join(parts, sep)
    local nonempty = {}
    for _, p in ipairs(parts) do
        if p ~= '' then
            nonempty[#nonempty + 1] = p
        end
    end
    return table.concat(nonempty, sep)
end

local M = {}
function M.render()
    local left = join({ filename(), location(), diagnostics() }, '  ')
    local right = join({ lsp(), word_count(),encoding(), file_format(), shift_width(), branch() }, '  ')
    return table.concat({ mode(), '  ', left, '%=', right, '  ' })
end

set_highlights()
vim.o.statusline = "%!v:lua.require'statusline'.render()"

local group = vim.api.nvim_create_augroup('statusline', {})
vim.api.nvim_create_autocmd('ColorScheme', { group = group, callback = set_highlights, })

local function redraw() vim.cmd.redrawstatus() end

vim.api.nvim_create_autocmd('DiagnosticChanged', { group = group, callback = redraw })
vim.api.nvim_create_autocmd('User', { group = group, pattern = 'GitSignsUpdate', callback = redraw })
-- scheduled so a detaching client is already gone from get_clients() when redrawn
vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach' }, {
    group = group,
    callback = function() vim.schedule(redraw) end,
})

return M
