local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    preview = {
      default = 'bat',
    },
  },
})

vim.keymap.set('n', '<leader>sp', fzf.live_grep_native, { desc = 'Search project' })
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search files' })
