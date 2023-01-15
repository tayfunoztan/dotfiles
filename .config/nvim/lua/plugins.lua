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

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -----------------------------------------------------------------------------//
  -- Core {{{1
  -----------------------------------------------------------------------------//
  use("nvim-lua/plenary.nvim")

  use({ "folke/which-key.nvim" })

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
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 15
    end,
  })

  use({ "kyazdani42/nvim-web-devicons" })

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

  -- }}}
  --------------------------------------------------------------------------------
  -- TPOPE {{{1
  --------------------------------------------------------------------------------
  use({
    "tpope/vim-fugitive",
    cmd = { "Git", "Gvsplit", "Gdiffsplit", "Gvdiffsplit" },
  })
  use("tpope/vim-rhubarb")
  use("tpope/vim-repeat")
  -- use("tpope/vim-surround")
  -- use("tpope/vim-commentary")
  -- }}}
  --------------------------------------------------------------------------------
  -- Git {{{1
  --------------------------------------------------------------------------------
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
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    module = "diffview",
    config = function()
      require("config.diffview").config()
    end,
    setup = function()
      require("config.diffview").setup()
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
  ---}}}
  -----------------------------------------------------------------------------//
  -- LSP,Completion & Debugger {{{1
  -----------------------------------------------------------------------------//
  use({
    "williamboman/mason.nvim",
    -- event = 'BufRead',
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
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

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
      -- HACK: prevent error when exiting Neovim
      vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
    end,
  })

  -- }}}
  -----------------------------------------------------------------------------//
  -- Filetype Plugins {{{1
  -----------------------------------------------------------------------------//
  -- use({
  --   "fatih/vim-go",
  --   run = ":GoUpdateBinaries",
  --   setup = function()
  --     vim.g.go_code_completion_enabled = 0
  --     vim.g.go_def_mapping_enabled = 0
  --     vim.g.go_echo_go_info = 0
  --     vim.g.gopls_enabled = 0
  --     vim.g.go_doc_keywordprg_enabled = 0
  --
  --     -- vim.g.go_imports_mode = "gopls"
  --     -- vim.g.go_imports_autosave = 1
  --     -- vim.g.go_gopls_complete_unimported = 1
  --     -- vim.g.go_fmt_command = "goimports"
  --
  --     vim.g.go_test_show_name = 0
  --     vim.g.go_list_type = "quickfix"
  --
  --     vim.g.go_highlight_build_constraints = 1
  --     vim.g.go_highlight_operators = 1
  --     vim.g.go_highlight_extra_types = 0
  --     vim.g.go_highlight_functions = 1
  --     vim.g.go_highlight_function_parameters = 0
  --     vim.g.go_highlight_function_calls = 1
  --     vim.g.go_highlight_types = 1
  --     vim.g.go_highlight_fields = 1
  --   end,
  -- })

  use({
    "olexsmir/gopher.nvim",
    requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  })

  use({
    "folke/neodev.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("neodev").setup()
    end,
  })

  use("simrat39/rust-tools.nvim")

  use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" })

  ---}}}
  -----------------------------------------------------------------------------//
  -- UI {{{1
  -----------------------------------------------------------------------------//
  use({
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 3000,
        stages = "static",
      })
      vim.notify = notify
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    config = function()
      require("config.feline")
    end,
  })

  use({
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("config.bufferline")
    end,
    requires = "kyazdani42/nvim-web-devicons",
  })

  use({
    "b0o/incline.nvim",
    config = function()
      require("config.incline")
    end,
  })

  ---}}}
  --------------------------------------------------------------------------------
  -- Syntax {{{1
  --------------------------------------------------------------------------------
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  })
  ---}}}
  --------------------------------------------------------------------------------
  -- Utilities {{{1
  --------------------------------------------------------------------------------
  use("christoomey/vim-tmux-navigator")

  use("tayfunoztan/ReplaceWithRegister")

  use({
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({})
    end,
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  ---}}}
  --------------------------------------------------------------------------------
  -- Themes  {{{1
  --------------------------------------------------------------------------------
  use({
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard" or "soft"
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  })

  use({ "LunarVim/horizon.nvim" })
  use("navarasu/onedark.nvim")
  use("folke/tokyonight.nvim")

  ---}}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- vim:foldmethod=marker nospell
