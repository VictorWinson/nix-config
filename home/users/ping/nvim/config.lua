-- Completion
local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.setup({})
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      },
    },
  },
})

pcall(telescope.load_extension, 'fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help' })

-- fzf-lua
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

-- Treesitter
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { 'nix', 'bash', 'lua', 'python', 'json', 'vim' },
})

-- LSP
local lspconfig = require('lspconfig')

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

local on_attach = function(_, bufnr)
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

-- Scrollbar
require('scrollbar.handlers.search').setup()
require('scrollbar').setup({
  show = true,
  handle = {
    text = ' ',
    color = '#928374',
    hide_if_all_visible = true,
  },
  marks = {
    Search = { color = 'yellow' },
    Misc = { color = 'purple' },
  },
  handlers = {
    cursor = false,
    diagnostic = true,
    gitsigns = true,
    handle = true,
    search = true,
  },
})

-- Dropbar
local dropbar = require('dropbar')
local api = require('dropbar.api')

vim.keymap.set('n', '<Leader>;', api.pick)
vim.keymap.set('n', '[c', api.goto_context_start)
vim.keymap.set('n', ']c', api.select_next_context)

local confirm = function()
  local menu = api.get_current_dropbar_menu()
  if not menu then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(menu.win)
  local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
  if component then
    menu:click_on(component)
  end
end

local quit_curr = function()
  local menu = api.get_current_dropbar_menu()
  if menu then
    menu:close()
  end
end

dropbar.setup({
  menu = {
    quick_navigation = true,
    keymaps = {
      ['<LeftMouse>'] = function()
        local menu = api.get_current_dropbar_menu()
        if not menu then
          return
        end
        local mouse = vim.fn.getmousepos()
        if mouse.winid ~= menu.win then
          local parent_menu = api.get_dropbar_menu(mouse.winid)
          if parent_menu and parent_menu.sub_menu then
            parent_menu.sub_menu:close()
          end
          if vim.api.nvim_win_is_valid(mouse.winid) then
            vim.api.nvim_set_current_win(mouse.winid)
          end
          return
        end
        menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
      end,
      ['<CR>'] = confirm,
      ['i'] = confirm,
      ['<esc>'] = quit_curr,
      ['q'] = quit_curr,
      ['n'] = quit_curr,
      ['<MouseMove>'] = function()
        local menu = api.get_current_dropbar_menu()
        if not menu then
          return
        end
        local mouse = vim.fn.getmousepos()
        if mouse.winid ~= menu.win then
          return
        end
        menu:update_hover_hl({ mouse.line, mouse.column - 1 })
      end,
    },
  },
})

-- Bufferline
require('bufferline').setup({
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    enforce_regular_tabs = true,
    show_duplicate_prefix = false,
    tab_size = 16,
    padding = 0,
    separator_style = 'thick',
  },
})

-- Markdown helpers
vim.g.vmt_cycle_list_item_markers = 1
vim.g.vmt_fence_text = 'TOC'
vim.g.vmt_fence_closing_text = '/TOC'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.cmd('TableModeEnable')
  end,
})

-- Core UI polish
require('lualine').setup({
  icons_enabled = true,
  theme = 'onedark',
})

require('Comment').setup()
pcall(require('leap').add_default_mappings)
vim.cmd('colorscheme gruvbox')
