{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "victorWinson";
      user.email = "ping670301@gmail.com";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.path = "/$HOME/dotfiles/zsh/.zsh_history";
    history.size = 100000;
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      vide = "neovide";
      cat = "bat -p";
      ra = "joshuto";
      jo = "joshuto";
      mv = "mv -i";
      traceroute = "mtr";
      df = "pydf";
      du = "dust";
      cloc = "tokei";
      neofetch = "fastfetch";

      find = "fd";
      ls = "exa";
      ll = "exa -alh";
      la = "exa -a";
      tree = "exa --tree";

      nmap = "echo might want to try rustscan && nmap";

      tt = "task sync && taskwarrior-tui && task sync";
      t = "task sync && task";

      rustlings = "cd ~/projects/rustlings && vide exercises && rustlings watch";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = false;
    };
  };
}
