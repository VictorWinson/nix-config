{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp
      pyright
      xclip
      wl-clipboard
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
      cursorline = true;
      ignorecase = true;
      smartcase = true;
      splitbelow = true;
      splitright = true;
      updatetime = 250;
      signcolumn = "yes";
      scrolloff = 5;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>quit<cr>";
        options.desc = "Quit window";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options.desc = "Save buffer";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      nvim-lspconfig
      neodev-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      friendly-snippets
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      fzf-lua
      lualine-nvim
      nvim-web-devicons
      leap-nvim
      nvim-scrollbar
      undotree
      dropbar-nvim
      nui-nvim
      markdown-preview-nvim
      vim-table-mode
      vim-markdown-toc
      bufferline-nvim
      nvim-treesitter
      nvim-treesitter-playground
      nvim-treesitter-context
      vim-nix
      comment-nvim
    ];

    extraConfigLua = builtins.readFile ../nvim/config.lua;
  };
}
