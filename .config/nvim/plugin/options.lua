local fn = vim.fn

vim.wo.number = true

-------------------------------------------------------------------------------
-- BACKUP AND SWAPS {{{
-------------------------------------------------------------------------------
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- if fn.isdirectory(vim.o.undodir) == 0 then
--   fn.mkdir(vim.o.undodir, 'p')
-- end
-- vim.opt.undofile = true
-- vim.opt.swapfile = false
-- -- The // at the end tells Vim to use the absolute path to the file to create the swap file.
-- -- This will ensure that swap file name is unique, so there are no collisions between files
-- -- with the same name from different directories.
-- vim.opt.directory = fn.stdpath 'data' .. '/swap//'
-- if fn.isdirectory(vim.o.directory) == 0 then
--   fn.mkdir(vim.o.directory, 'p')
-- end
--}}}
