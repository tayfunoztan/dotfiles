local M = {}

function M.install_missing(servers)
  local lspi_servers = require("nvim-lsp-installer.servers")
  for server, _ in pairs(servers) do
    local ok, s = lspi_servers.get_server(server)
    if ok then
      if not s:is_installed() then
        s:install()
      end
    end
  end
end

function M.setup(servers, options)
  local lspi = require("nvim-lsp-installer")
  lspi.on_server_ready(function(server)
    local config = type(servers[server.name]) == "table" and servers[server.name]
      or type(servers[server.name]) == "function" and servers[server.name]()
      or {}
    local opts = vim.tbl_deep_extend("force", options, config)

    -- local server_opts = {
    --   ["gopls"] = function()
    --     return vim.tbl_deep_extend("force", opts, {
    --       init_options = {
    --         usePlaceholders = true,
    --         completeUnimported = true,
    --       },
    --     })
    --   end,
    --   ["sumneko_lua"] = function()
    --     return require("lua-dev").setup({
    --       lspconfig = vim.tbl_deep_extend("force", opts, {
    --         settings = {
    --           Lua = {
    --             diagnostics = {
    --               globals = {
    --                 "vim",
    --                 "describe",
    --                 "it",
    --                 "before_each",
    --                 "after_each",
    --                 "pending",
    --                 "teardown",
    --                 "packer_plugins",
    --               },
    --             },
    --           },
    --         },
    --       }),
    --     })
    --   end,
    -- }

    if server.name == "rust_analyzer" then
      require("rust-tools").setup({
        server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
      })
      server:attach_buffers()
      return
    end

    server:setup(opts)
  end)

  M.install_missing(servers)
end

return M
