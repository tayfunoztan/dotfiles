return {
    -- library used by other plugins
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'MunifTanjim/nui.nvim', lazy = true },
    { 'stevearc/dressing.nvim', lazy = true },
    { 'tpope/vim-repeat', event = 'VeryLazy' },

    {
        'nvim-tree/nvim-web-devicons',
        -- Lots of plugins will require this later.
        lazy = true,
        opts = {},
    },
}
