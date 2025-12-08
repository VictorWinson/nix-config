return {
	{
		    "iamcco/markdown-preview.nvim",
    		    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    		    ft = { "markdown" },
    		    build = function() 
			    vim.fn["mkdp#util#install"]() 
		    end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		config = function()
			vim.cmd('TableModeEnable')
		end,
	},
	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown" },
		config = function()
			-- let g:vmt_auto_update_on_save = 0
			-- let g:vmt_dont_insert_fence = 1
			vim.g.vmt_cycle_list_item_markers = 1
			vim.g.vmt_fence_text = 'TOC'
			vim.g.vmt_fence_closing_text = '/TOC'
		end,
	}
}
