-- `f` + one char + label jumps anywhere in the visible window (no direction).
-- F / t / T and operator-pending `f` (e.g. `dfx`) stay Vim's native motions.
return {
    'smoka7/hop.nvim',
    keys = {
        { 'f', function() require('hop').hint_char1() end, mode = 'n', desc = 'hop: jump to char' },
    },
    opts = {},
}
