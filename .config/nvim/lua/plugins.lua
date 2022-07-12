local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

pcall(require, "impatient")

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- TODO: this fixes a bug in neovim core that prevents "CursorHold" from working
  -- hopefully one day when this issue is fixed this can be removed
  -- @see: https://github.com/neovim/neovim/issues/12587
  use("antoinemadec/FixCursorHold.nvim")

  --------------------------------------------------------------------------------
  -- Profiling & Startup
  --------------------------------------------------------------------------------
  -- TODO: this plugin will be redundant once https://github.com/neovim/neovim/pull/15436 is merged
  use("lewis6991/impatient.nvim")
  use({
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 15
      vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" }
    end,
  })

  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  use({
    "tpope/vim-fugitive",
    cmd = { "Git", "Gvsplit", "Gdiffsplit", "Gvdiffsplit" },
  })
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-commentary")

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = { "<localleader>gs", "<localleader>gp", "<localleader>gP" },
    config = function()
      require("config.neogit").config()
    end,
    setup = function()
      require("config.neogit").setup()
    end,
  })

  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    module = "diffview",
    config = function()
      require("config.diffview")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })

  use({ "junegunn/fzf", run = "./install --all" })
  use({
    "junegunn/fzf.vim",
    config = function()
      vim.g.fzf_command_prefix = "Fzf"
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = { "<leader>ff", "<leader>fo", "<leader>fg", "<leader>fb" },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function()
      require("config.telescope")
    end,
  })

  use({
    "williamboman/mason.nvim",
    -- event = 'BufRead',
    branch = "alpha",
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    after = "mason.nvim",
    config = function()
      require("config.lspconfig")
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("config.null-ls")
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.nvim-cmp")
    end,
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      {
        "L3MON4D3/LuaSnip",
        requires = "rafamadriz/friendly-snippets",
        config = function()
          require("config.luasnip")
        end,
      },
    },
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  })

  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  use("christoomey/vim-tmux-navigator")
  use("tayfunoztan/ReplaceWithRegister")
  use({
    "Raimondi/delimitMate",
    config = function()
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_smart_quotes = 1
      vim.g.delimitMate_expand_inside_quotes = 1
    end,
  })
  use({
    "AndrewRadev/splitjoin.vim",
    keys = { "gJ", "gS" },
  })

  use({
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
    end,
  })

  use("folke/lua-dev.nvim")

  use("simrat39/rust-tools.nvim")
  use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" })

  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    keys = "<leader>n",
    cmd = "NeoTree",
    config = function()
      require("config.neo-tree")
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  })

  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
  })

  -- use({
  --   "akinsho/nvim-bufferline.lua",
  --   config = function()
  --     require("config.bufferline")
  --   end,
  --   requires = "kyazdani42/nvim-web-devicons",
  -- })

  use({
    "b0o/incline.nvim",
    config = function()
      require("config.incline")
    end,
  })

  -- use({
  --   "phaazon/hop.nvim",
  --   branch = "v2", -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
  --   end,
  -- })

  -- use({
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require("neoscroll").setup({
  --       mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-e>", "<C-y>", "zt", "zz", "zb" },
  --       stop_eof = true,
  --       hide_cursor = true,
  --     })
  --   end,
  -- })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  })

  use({
    "tayfunoztan/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard" or "soft"
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  })

  -- use({
  --   "gruvbox-community/gruvbox",
  --   config = function()
  --     vim.g.gruvbox_contrast_dark = "hard"
  --     vim.g.gruvbox_contrast_light = "hard"
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  -- })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
