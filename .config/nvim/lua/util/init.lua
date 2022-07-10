_G.lsp = {}
_G.map = {}

----------------------------------------------------------------------------------------------------
-- Mappings
----------------------------------------------------------------------------------------------------

---create a mapping function factory
---@param mode string
---@param o table
---@return fun(lhs: string, rhs: string|function, opts: table|nil) 'create a mapping'
local function make_mapper(mode, o)
  -- copy the opts table as extends will mutate the opts table passed in otherwise
  local parent_opts = vim.deepcopy(o)
  ---Create a mapping
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts table
  return function(lhs, rhs, opts)
    -- If the label is all that was passed in, set the opts automagically
    opts = type(opts) == "string" and { desc = opts } or opts and vim.deepcopy(opts) or {}
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("keep", opts, parent_opts))
  end
end

local map_opts = { remap = true, silent = true }
local noremap_opts = { silent = true }

-- A recursive commandline mapping
map.nmap = make_mapper("n", map_opts)
-- A recursive select mapping
map.xmap = make_mapper("x", map_opts)
-- A recursive terminal mapping
map.imap = make_mapper("i", map_opts)
-- A recursive operator mapping
map.vmap = make_mapper("v", map_opts)
-- A recursive insert mapping
map.omap = make_mapper("o", map_opts)
-- A recursive visual & select mapping
map.tmap = make_mapper("t", map_opts)
-- A recursive visual mapping
map.smap = make_mapper("s", map_opts)
-- A recursive normal mapping
map.cmap = make_mapper("c", { remap = true, silent = false })
-- A non recursive normal mapping
map.nnoremap = make_mapper("n", noremap_opts)
-- A non recursive visual mapping
map.xnoremap = make_mapper("x", noremap_opts)
-- A non recursive visual & select mapping
map.vnoremap = make_mapper("v", noremap_opts)
-- A non recursive insert mapping
map.inoremap = make_mapper("i", noremap_opts)
-- A non recursive operator mapping
map.onoremap = make_mapper("o", noremap_opts)
-- A non recursive terminal mapping
map.tnoremap = make_mapper("t", noremap_opts)
-- A non recursive select mapping
map.snoremap = make_mapper("s", noremap_opts)
-- A non recursive commandline mapping
map.cnoremap = make_mapper("c", { silent = false })
