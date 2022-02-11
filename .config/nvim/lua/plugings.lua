local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end


return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'

    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }
    use 'junegunn/vim-peekaboo'

    use 'nvim-lua/plenary.nvim'

    use 'nvim-telescope/telescope.nvim'
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


    use 'christoomey/vim-tmux-navigator'
    use 'tayfunoztan/ReplaceWithRegister'
    use 'Raimondi/delimitMate'
    use {
      "AndrewRadev/splitjoin.vim",
      keys = { "gJ", "gS" },
    }

    use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
    use 'simrat39/rust-tools.nvim'
    use 'othree/yajs.vim'
    use 'MaxMEllon/vim-jsx-pretty'
    use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    use 't9md/vim-choosewin'
    use 'kyazdani42/nvim-tree.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'
    use 'gruvbox-community/gruvbox'
    --  let g:gruvbox_contrast_dark='hard'

  end
}
