map.imap("jj", [['<esc>']], { expr = true })

-----------------------------------------------------------------------------//
-- Terminal
------------------------------------------------------------------------------//
vim.api.nvim_create_augroup("AddTerminalMappings", {})
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = "AddTerminalMappings",
  pattern = { "term://*" },
  callback = function()
    if vim.bo.filetype == "" or vim.bo.filetype == "toggleterm" then
      local opts = { silent = false, buffer = 0 }
      map.tnoremap("<esc>", [[<C-\><C-n>]], opts)
      map.tnoremap("jj", [[<C-\><C-n>]], opts)
      map.tnoremap("<C-h>", [[<C-\><C-n><C-W>h]], opts)
      map.tnoremap("<C-j>", [[<C-\><C-n><C-W>j]], opts)
      map.tnoremap("<C-k>", [[<C-\><C-n><C-W>k]], opts)
      map.tnoremap("<C-l>", [[<C-\><C-n><C-W>l]], opts)
      -- tnoremap(']t', [[<C-\><C-n>:tablast<CR>]])
      -- tnoremap('[t', [[<C-\><C-n>:tabnext<CR>]])
      -- tnoremap('<S-Tab>', [[<C-\><C-n>:bprev<CR>]])
      -- tnoremap('<leader><Tab>', [[<C-\><C-n>:close \| :bnext<cr>]])
    end
  end,
})
