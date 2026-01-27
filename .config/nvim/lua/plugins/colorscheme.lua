return {
    -- the colorscheme should be available when starting Neovim
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        -- priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('catppuccin').setup {
                flavour = 'auto', -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = 'latte',
                    dark = 'macchiato',
                },
                integrations = {
                    blink_cmp = true,
                    diffview = true,
                    mason = true,
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { 'undercurl' },
                            hints = { 'undercurl' },
                            warnings = { 'undercurl' },
                            information = { 'undercurl' },
                        },
                    },
                    nvim_surround = true,
                    treesitter = true,
                    treesitter_context = true,
                    which_key = true,
                },
            }

            -- vim.cmd([[colorscheme catppuccin]])
            -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#303347", fg = "#f4dbd6" })
        end,
        -- specs = {
        --   -- {
        --   --   "akinsho/bufferline.nvim",
        --   --   optional = true,
        --   --   opts = function(_, opts)
        --   --     opts.highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
        --   --   end,
        --   -- },
        -- },
    },
    {
        'nickkadutskyi/jb.nvim',
        -- lazy = false,
        -- priority = 1000,
        opts = {},
        config = function()
            -- require("jb").setup({transparent = true})
            -- vim.cmd("colorscheme jb")
            -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#303347", fg = "#f4dbd6" })
        end,
    },
    -- {
    --   "ellisonleao/gruvbox.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   opts = {},
    --   config = function()
    --     require("gruvbox").setup({
    --       contrast = "hard", -- can be "hard", "soft" or empty string
    --     })
    --     -- vim.cmd([[colorscheme gruvbox]])
    --     -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#303347", fg = "#f4dbd6" })
    --   end,
    -- },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_background = 'hard'
            -- vim.cmd.colorscheme("gruvbox-material")
        end,
    },
    {
        'navarasu/onedark.nvim',
        -- priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- require("onedark").setup({
            --   style = "darker",
            -- })
            -- Enable theme
            require('onedark').load()
        end,
    },
}
