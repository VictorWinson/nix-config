--vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '
--
--vim.o.clipboard = 'unnamedplus'
--
--vim.o.number = true
---- vim.o.relativenumber = true
--
--vim.o.signcolumn = 'yes'
--
--vim.o.tabstop = 4
--vim.o.shiftwidth = 4
--
--vim.o.updatetime = 300
--
--vim.o.termguicolors = true
--
--vim.o.mouse = 'a'

-------------
-- general --
-------------
vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.opt.clipboard:append('unnamedplus')
vim.o.ttyfast = true
vim.o.autochdir = true
vim.o.exrc = true
vim.o.secure = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.list = true
vim.o.listchars = 'tab:|\\ ,trail:▫'
vim.o.scrolloff = 4
vim.o.ttimeoutlen = 0
vim.o.timeout = false
vim.o.viewoptions = 'cursor,folds,slash,unix'
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ''
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.inccommand = 'split'
vim.o.completeopt = 'longest,noinsert,menuone,noselect,preview'
vim.o.completeopt = 'menuone,noinsert,noselect,preview'
-- vim.o.lazyredraw = true
vim.o.visualbell = true
vim.o.colorcolumn = '100'
vim.o.updatetime = 100
vim.o.virtualedit = 'block'
vim.o.guifont = "Source Code Pro:h20:#h-slight"

vim.cmd([[
silent !mkdir -p $HOME/.config/.nvim-tmp/backup
silent !mkdir -p $HOME/.config/.nvim-tmp/undo
"silent !mkdir -p $HOME/.config/.nvim-tmp/sessions
set backupdir=$HOME/.config/.nvim-tmp/backup,.
set directory=$HOME/.config/.nvim-tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/.nvim-tmp/undo,.
endif
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })

vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

vim.g.terminal_color_0  = '#000000'
vim.g.terminal_color_1  = '#FF5555'
vim.g.terminal_color_2  = '#50FA7B'
vim.g.terminal_color_3  = '#F1FA8C'
vim.g.terminal_color_4  = '#BD93F9'
vim.g.terminal_color_5  = '#FF79C6'
vim.g.terminal_color_6  = '#8BE9FD'
vim.g.terminal_color_7  = '#BFBFBF'
vim.g.terminal_color_8  = '#4D4D4D'
vim.g.terminal_color_9  = '#FF6E67'
vim.g.terminal_color_10 = '#5AF78E'
vim.g.terminal_color_11 = '#F4F99D'
vim.g.terminal_color_12 = '#CAA9FA'
vim.g.terminal_color_13 = '#FF92D0'
vim.g.terminal_color_14 = '#9AEDFE'
vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
]])

vim.cmd([[hi NonText ctermfg=gray guifg=grey10]])

--local config_path = vim.fn.stdpath("config")
--local current_config_path = config_path .. "/lua/config/machine_specific.lua"
--if not vim.loop.fs_stat(current_config_path) then
--	local current_config_file = io.open(current_config_path, "wb")
--	local default_config_path = config_path .. "/default_config/_machine_specific_default.lua"
--	local default_config_file = io.open(default_config_path, "rb")
--	if default_config_file and current_config_file then
--		local content = default_config_file:read("*all")
--		current_config_file:write(content)
--		io.close(default_config_file)
--		io.close(current_config_file)
--	end
--end
--require("config.machine_specific")


--------------
-- key maps --
--------------
vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "u" }
local nmappings = {
	{ from = "S", to = ":w<CR>" },
	--	{ from = "Q",             to = ":q<CR>" },
	{ from = ";", to = ":", mode = mode_nv },
	--	{ from = "Y", to = "\"+y", mode = mode_v },
	{ from = "`", to = "~", mode = mode_nv },
	{ from = "l", to = "u", mode = mode_v },
	{ from = "L", to = "U", mode = mode_v },

	-- Movement
	{ from = "e", to = "k", mode = mode_nv },
	{ from = "n", to = "j", mode = mode_nv },
	--	{ from = "h",             to = "h",                                                                   mode = mode_nv },
	{ from = "i", to = "l", mode = mode_nv },
	{ from = "E", to = "5k", mode = mode_nv },
	{ from = "N", to = "5j", mode = mode_nv },
	{ from = "H", to = "0", mode = mode_nv },
	{ from = "I", to = "$", mode = mode_nv },
	{ from = "ge", to = "gk", mode = mode_nv },
	{ from = "gn", to = "gj", mode = mode_nv },
	--	{ from = "h",             to = "e",                                                                   mode = mode_nv },
	--	{ from = "<C-U>",         to = "5<C-y>",                                                              mode = mode_nv },
	--	{ from = "<C-E>",         to = "5<C-e>",                                                              mode = mode_nv },
	{ from = "cu", to = "cl", },
	--	{ from = "ch",            to = "ch", },
	{ from = "ce", to = "ci", },
	{ from = "c,.", to = "c%", },
	{ from = "yf", to = "ye", },

	-- Actions
	{ from = "l", to = "u" },
	{ from = "u", to = "i", mode = mode_nv },
	{ from = "U", to = "I", mode = mode_nv },
	{ from = "k", to = "n", mode = mode_nv },
	{ from = "K", to = "N", mode = mode_nv },

	-- Useful actions
	{ from = ",.", to = "%", mode = mode_nv },
	--	{ from = "<c-y>",         to = "<ESC>A {}<ESC>i<CR><ESC>ko",                                          mode = mode_i },
	--	{ from = "\\v",           to = "v$h", },
	--	{ from = "<c-a>",         to = "<ESC>A",                                                              mode = mode_i },

	-- Window & splits
	{ from = "<leader>w", to = "<C-w>w", },
	{ from = "<leader>e", to = "<C-w>k", },
	{ from = "<leader>n", to = "<C-w>j", },
	{ from = "<leader>h", to = "<C-w>h", },
	{ from = "<leader>i", to = "<C-w>l", },
	{ from = "qf", to = "<C-w>o", },
	{ from = "s", to = "<nop>", },
	{ from = "se", to = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", },
	{ from = "sn", to = ":set splitbelow<CR>:split<CR>", },
	{ from = "sh", to = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", },
	{ from = "si", to = ":set splitright<CR>:vsplit<CR>", },
	{ from = "<up>", to = ":res +5<CR>", },
	{ from = "<down>", to = ":res -5<CR>", },
	{ from = "<left>", to = ":vertical resize-5<CR>", },
	{ from = "<right>", to = ":vertical resize+5<CR>", },
	-- { from = "sh",            to = "se", },
	-- { from = "sh",            to = "<C-w>t<C-w>K", },
	-- { from = "sv",            to = "<C-w>t<C-w>H", },
	{ from = "sre", to = "<C-w>b<C-w>K", },
	{ from = "srn", to = "<C-w>b<C-w>H", },

	-- Tab management
	{ from = "tu", to = ":tabe<CR>", },
	{ from = "tU", to = ":tab split<CR>", },
	{ from = "tn", to = ":-tabnext<CR>", },
	{ from = "ti", to = ":+tabnext<CR>", },
	{ from = "tmn", to = ":-tabmove<CR>", },
	{ from = "tmi", to = ":+tabmove<CR>", },

	-- Other
	{ from = "<leader>sw", to = ":set wrap<CR>" },
	{ from = "<leader><CR>", to = ":nohlsearch<CR>" },
	{ from = "<f10>", to = ":TSHighlightCapturesUnderCursor<CR>" },
	{ from = "<leader>o", to = "za" },
	{ from = "<leader>pr", to = ":profile start profile.log<CR>:profile func *<CR>:profile file *<CR>" },
	{ from = "<leader>rc", to = ":e ~/.config/nvim/init.lua<CR>" },
	{ from = "<leader>rv", to = ":e .vim.lua<CR>" },
	{ from = ",v", to = "v%" },
	{ from = "<leader><esc>", to = "<nop>" },

	-- Joshuto
	{ from = "R", to = ":Joshuto<CR>" },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

local function run_vim_shortcut(shortcut)
	local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
	vim.api.nvim_feedkeys(escaped_shortcut, 'n', true)
end

-- close win below
vim.keymap.set("n", "<leader>q", function()
	vim.cmd("TroubleClose")
	local wins = vim.api.nvim_tabpage_list_wins(0)
	if #wins > 1 then
		run_vim_shortcut([[<C-w>j:q<CR>]])
	end
end, { noremap = true, silent = true })

-----------------------
-- customized plugin --
-----------------------

local compileRun = function()
    local current_file = vim.fn.expand('%:p')
    vim.cmd("w")
    -- check file type
    local ft = vim.bo.filetype
    if ft == "dart" then
        vim.cmd(":FlutterRun -d " .. vim.g.flutter_default_device .. " " .. vim.g.flutter_run_args .. "<CR>")
    elseif ft == "markdown" then
        vim.cmd("InstantMarkdownPreview")
    elseif ft == "rust" then
        local command = string.format('rustc %s -o out && time ./out', current_file)
        vim.cmd('! ' .. command)
    elseif ft == "python" then
        local command = string.format('python %s', current_file)
        vim.cmd('! ' .. command)
    end
end

vim.keymap.set('n', '<leader>nr', compileRun, { silent = true })
