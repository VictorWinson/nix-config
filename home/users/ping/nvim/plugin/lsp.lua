local lspconfig = require('lspconfig')

-- diagnostic UI
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
  map('n', 'K', vim.lsp.buf.hover, 'Hover docs')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
  map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.rnix.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
