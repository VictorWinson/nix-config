{ inputs, pkgs, ... }:
let
  luaConfig = builtins.readFile;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

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

    colorschemes.gruvbox.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      comment-nvim
      gruvbox-nvim
      neodev-nvim
      nvim-lspconfig
      nvim-cmp
      telescope-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons
      fzf-lua
      leap-nvim
      nvim-scrollbar
      undotree
      winbar-nvim
      markdown-preview-nvim
      vim-table-mode
      tabline-nvim
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-json
      ]))
      vim-nix
    ];

    extraConfigLua = ''
      ${luaConfig ../nvim/options.lua}
      ${luaConfig ../nvim/plugin/lsp.lua}
      ${luaConfig ../nvim/plugin/cmp.lua}
      ${luaConfig ../nvim/plugin/telescope.lua}
      ${luaConfig ../nvim/plugin/fzf.lua}
      ${luaConfig ../nvim/plugin/treesitter.lua}
    '';
  };
}
