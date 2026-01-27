return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        -- lazy = false, -- neo-tree will lazily load itself
        keys = {
            { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Explorer NeoTree', remap = true },
            {
                '<leader>be',
                function()
                    require('neo-tree.command').execute { source = 'buffers', toggle = true }
                end,
                desc = 'Buffer Explorer',
            },
            { '<leader>bs', '<cmd>Neotree reveal<cr>', desc = 'Buffer Path Explorer', remap = true },
        },
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
            -- fill any relevant options here
            source_selector = {
                winbar = true,
            },
        },
    },
}
