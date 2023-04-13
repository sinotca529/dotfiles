local function vimtex()
    return {
        'lervag/vimtex',
        config = function()
            vim.g.maplocalleader = ','
            vim.g.vimtex_view_general_viewer = 'zathura'
            vim.g.vimtex_view_general_options = '-x \"nvr +%{line} %{input}\" --synctex-forward @line:0:@tex @pdf'
        end
    }
end

return function(plugins)
    plugins[#plugins+1] = vimtex()
end
