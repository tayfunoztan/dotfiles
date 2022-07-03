local api = vim.api
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd
local my_group = vim.api.nvim_create_augroup("ToztanGroup", {})

autocmd("TextYankPost", {
  group = my_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      timeout = 400,
      higroup = "IncSearch",
    })
  end,
})

-- show cursor line only in active window
cmd([[
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
]])

cmd([[
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go nmap <silent> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r <Plug>(go-run)
  " autocmd FileType go nmap <silent> <leader>r :GoRun . <CR>
  " autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  " autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
]])
