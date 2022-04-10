local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd(
    [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)

return require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"

        use "lewis6991/impatient.nvim"
        use {
            "dstein64/vim-startuptime",
            cmd = "StartupTime",
            config = function()
                vim.g.startuptime_tries = 15
                vim.g.startuptime_exe_args = {"+let g:auto_session_enabled = 0"}
            end
        }

        use "nvim-lua/plenary.nvim"
        use "nvim-lua/popup.nvim"

        use {
            "tpope/vim-fugitive",
            cmd = {"Git", "Gvsplit", "Gdiffsplit", "Gvdiffsplit"}
        }
        use "tpope/vim-rhubarb"
        use "tpope/vim-surround"
        use "tpope/vim-repeat"
        use "tpope/vim-commentary"

        use {"junegunn/fzf", run = "./install --all"}
        use {"junegunn/fzf.vim"}
        -- use 'junegunn/vim-peekaboo'

        use {
            "TimUntersberger/neogit",
            cmd = "Neogit",
            config = function()
                require("config.neogit")
            end
        }

        use {
            "sindrets/diffview.nvim",
            cmd = {"DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles"},
            module = "diffview",
            config = function()
                require("config.diffview")
            end
        }

        use {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("config.gitsigns")
            end
        }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = {"Telescope"},
            keys = {"<leader>ff", "<leader>fo", "<leader>fg", "<leader>fb"},
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-file-browser.nvim"}
            },
            config = function()
                require("config.telescope")
            end
        }

        -----------------------------------------------------------------------------//
        -- LSP,Completion & Debugger {{{1
        -----------------------------------------------------------------------------//
        use {
            "neovim/nvim-lspconfig",
            config = function()
                require("config.lspconfig")
            end,
            requires = {
                "williamboman/nvim-lsp-installer",
                "jose-elias-alvarez/null-ls.nvim"
            }
        }
        use {
            "hrsh7th/nvim-cmp",
            config = function()
                require("config.nvim-cmp")
            end,
            -- event = "InsertEnter",
            requires = {
                -- { "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp"},
                {"hrsh7th/cmp-path", after = "nvim-cmp"},
                {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
                {"hrsh7th/cmp-vsnip", after = "nvim-cmp"},
                {"hrsh7th/vim-vsnip", after = "nvim-cmp"},
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    config = function()
                        require("config.luasnip")
                    end
                }
            }
        }

        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

        use "christoomey/vim-tmux-navigator"
        use "tayfunoztan/ReplaceWithRegister"
        use "Raimondi/delimitMate"
        use {
            "AndrewRadev/splitjoin.vim",
            keys = {"gJ", "gS"}
        }

        use {
            "fatih/vim-go",
            run = ":GoUpdateBinaries",
            setup = function()
                vim.g.go_code_completion_enabled = 0
                vim.g.go_def_mapping_enabled = 0
                vim.g.go_echo_go_info = 0
                vim.g.gopls_enabled = 0
                vim.g.go_doc_keywordprg_enabled = 0

                -- vim.g.go_imports_mode = "gopls"
                -- vim.g.go_imports_autosave = 1
                -- vim.g.go_gopls_complete_unimported = 1
                -- vim.g.go_fmt_command = "goimports"

                vim.g.go_test_show_name = 0
                vim.g.go_list_type = "quickfix"

                vim.g.go_highlight_build_constraints = 1
                vim.g.go_highlight_operators = 1
                vim.g.go_highlight_extra_types = 0
                vim.g.go_highlight_functions = 1
                vim.g.go_highlight_function_parameters = 0
                vim.g.go_highlight_function_calls = 1
                vim.g.go_highlight_types = 1
                vim.g.go_highlight_fields = 1
            end
        }

        use "folke/lua-dev.nvim"

        use {
            "simrat39/rust-tools.nvim",
            config = function()
                require("rust-tools").setup({})
            end
        }
        use "othree/yajs.vim"
        use "MaxMEllon/vim-jsx-pretty"
        use {"iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install"}
        use "dag/vim-fish"

        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {}
            end
        }

        use {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("config.lualine")
            end
        }

        use {
            "karb94/neoscroll.nvim",
            config = function()
                require("neoscroll").setup {
                    mappings = {"<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-e>", "<C-y>", "zt", "zz", "zb"},
                    stop_eof = false,
                    hide_cursor = true
                }
            end
        }

        -- use {
        --   'petertriho/nvim-scrollbar',
        --   config = function()
        --     require('scrollbar').setup {
        --       -- handle = {
        --       --   color = require('as.highlights').get_hl('PmenuSbar', 'bg'),
        --       -- },
        --       -- NOTE: If telescope is not explicitly excluded this garbles input into its prompt buffer
        --       excluded_buftypes = { 'nofile', 'terminal', 'prompt' },
        --       excluded_filetypes = { 'packer', 'TelescopePrompt', 'NvimTree' },
        --     }
        --   end,
        -- }

        -- use {
        --   'akinsho/nvim-bufferline.lua',
        --   requires = 'kyazdani42/nvim-web-devicons',
        --   event = "BufReadPre",
        --   config = function()
        --     require('config.bufferline')
        --   end,
        -- }

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {}
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({default = true})
            end
        }

        use "t9md/vim-choosewin"
        use {
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("config.nvim-tree")
            end
        }
        use {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup()
            end
        }
        -- use 'arkav/lualine-lsp-progress'

        use "gruvbox-community/gruvbox"
        use "folke/tokyonight.nvim"
        use "~/dev/seoul256.nvim"
    end
}

-- vim:foldmethod=marker
