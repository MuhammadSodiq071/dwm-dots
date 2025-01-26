-- load defaults i.e lua_lsp
require("configs.lsp").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "clangd", "omnisharp", "pyright" }
local nvlsp = require "configs.lsp"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
