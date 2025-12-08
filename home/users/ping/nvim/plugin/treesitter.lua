require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { 'nix', 'bash', 'lua', 'python', 'json', 'vim' },
})
