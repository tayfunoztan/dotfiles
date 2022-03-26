local telescope = require("telescope")
local actions = require "telescope.actions"

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
	["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
	["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
       horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
       },
       vertical = {
          mirror = false,
       },
       width = 0.87,
       height = 0.80,
       preview_cutoff = 120,
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
	    theme = "ivy",
    }
  },
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers({sort_lastused = true})<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').command_history({sort_lastused = true})<cr>]], { noremap = true, silent = true })

