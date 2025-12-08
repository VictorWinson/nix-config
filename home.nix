{ config, pkgs, input, ... }: {
  # 注意修改这里的用户名与用户目录
  home.username = "ping";
  home.homeDirectory = "/home/ping";
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置

  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # git 相关配置
  programs.git = {
    enable = true;
    userName = "victorWinson";
    userEmail = "ping670301@gmail.com";
  };

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    # 如下是我常用的一些命令行工具，你可以根据自己的需要进行增删
    # neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    # ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    pydf
    #dust
    tealdeer
    cmake
    #python3
    appimage-run
    
    tmux

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    rustscan

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    brightnessctl
    dunst

    # media
    gimp
    meh
    ffmpeg-full
    mpv
    pipewire
    pamixer
    #pulseaudio
    #pulsemixer
    # cider ## using cider 2 appimage now
    exiftool
    mediainfo
    jellyfin-media-player
    #wlr-randr
    xdg-desktop-portal
    wireplumber

    # document
    pandoc
    tectonic
    zathura
    ocrmypdf
    mupdf

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    # hugo # static site generator
    glow # markdown previewer in terminal
    taskwarrior
    taskwarrior-tui

    powertop # display power comsumption 
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    bat
    neovide

    # bluetooth
    bluez
    blueman

    #logi
    logiops

    # internet
    clash-verge

    # battery
    #tlp

    # communication
    nchat

    # game
    hmcl

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    acpi
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    fzf

    # font
    font-awesome
    wofi-emoji
    noto-fonts-monochrome-emoji
  ];

  services.syncthing.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableAutosuggestions = true;
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
      
      #bbdown = "BBDown";
      
      tt = "task sync && taskwarrior-tui && task sync";
      t = "task sync && task";

      # temp
      rustlings = "cd ~/projects/rustlings && vide exercises && rustlings watch";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    #withPython3 = true;
    #extraPython3Packages = pkgs: with pkgs; [ pylint ];
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];


    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      fzf-lua
      {
        plugin = fzf-lua;
        config = toLuaFile ./nvim/plugin/fzf.lua;
      }


      leap-nvim
      nvim-scrollbar
      undotree
      winbar-nvim
      markdown-preview-nvim
      vim-table-mode
      tabline-nvim

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };

  programs.obs-studio = {
    enable = true;
  };

  programs.wofi = {
    enable = true;
    style = ''
      * {
          font-family: firaCode-nerd-font;
      }
      
      window {
          background-color: #7c818c;
      }'';
    settings = {
      location = "top-right";
      allow_markup = true;
      width = 250;
    };
  };

  programs.firefox = {
    enable = true;
  };

  # 启用 starship，这是一个漂亮的 shell 提示符
  programs.starship = {
    enable = true;
    # 自定义配置
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = false;
      #python = { 
      #  symbol = "󰌠 ";
      #};
      #rust = { 
      #  symbol = "󱘗 ";
      #};
      #c = { 
      #  symbol = "󰙱 ";
      #};
      #rlang = { 
      #  symbol = "󰟔 ";
      #};
      #golang = { 
      #  symbol = "󰟓 ";
      #};
      #nodejs = { 
      #  symbol = "󰌞 ";
      #};
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "nerd-fonts-source-code-pro, noto-emoji";
    	size = 18;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Corvine";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
  };


  programs.waybar = {
    enable = true;
    #style = ''
    #* {
    #  font-family: "nerd-fonts-source-code-pro", "noto-emoji", "Font Awesome 6 Free-Solid", "Font Awesome 6 Brands";
    #}'';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        output = [ "eDP-1" "HDMI-A-1" ];
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [];
        modules-right = [ "backlight" "cpu" "memory" "pulseaudio" "network" "battery" "tray" ]; # "backlight" 

        "hyprland/workspaces" = {
          format = "{name}";
          active-only = true;
        };
        
        cpu = {
          interval = 5;
        };

        memory = {
          interval = 5;
        };

        pulseaudio = {
          format = "vol:{volume}% {icon}";
          format-muted = "🔇";
          format-icons = {
            high = "🔊";
            medium = "🔉";
            low = "🔈";
            mute = "🔇";
          };
        };

        network = {
          interface = "wlp0s20f3";
          format-wifi = "{essid}: {ipaddr}";
          format-disconnected = "Disconnected";
          interval = 10;
        };

        battery = {
          bat = "BAT0";
          adapter = "AC";
          format = "{capacity}% {icon}";
          format-icons = {
            charging = "⚡";
            discharging = "🔋";
          };
        };

        backlight = {
          device = "intel_backlight";
          format = "{percent}%";
        };

        tray = {
          icon-size = 16;
          spacing = 5;
        };
      }; # mainBar
    }; # settings
  };

#  programs.waybar = {
#    enable = true;
#    settings = {
#      mainBar = {
#        layer = "top";
#        position = "top";
#        height = 30;
#        output = [
#          "eDP-1"
#          "HDMI-A-1"
#        ];
#        modules-left = [ "hyprland/workspaces" "hyprland/submap" "wlr/taskbar" ];
#	modules-center = [ "hyprland/window" ];
#	# modules-center = [ "sway/window" "custom/hello-from-waybar" ];
#        modules-right = [ "backlight" "custom/mymodule#with-css-id" "temperature" ];
#
#	"backlight" = {
#	    "device" = "intel_backlight";
#	    "format" = "{percent}% {icon}";
#	    #"format-icons" = ["", ""];
#	};
#        "hyprland/workspaces" = {
#	  active-only = true;
#        };
#	"hyprland/submap" = {
#	    "format" = "✌️ {}";
#	    "max-length" = 8;
#	    "tooltip" = false;
#	};
#        "custom/hello-from-waybar" = {
#          format = "hello {}";
#          max-length = 40;
#          interval = "once";
#          exec = pkgs.writeShellScript "hello-from-waybar" ''
#            echo "from within waybar"
#          '';
#        };
#      }; # mainBar
#    }; # settings
#  }; # waybar

  # alacritty - 一个跨平台终端，带 GPU 加速功能
  programs.alacritty = {
    enable = false;
    # 自定义配置
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 18;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable=true;
    settings = {
      exec-once = "waybar & syncthing & kitty & sudo logid -c ~/.config/logid.cfg";
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        follow_mouse = "1";
        kb_options = "caps:swapescape";
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "master";
        monitor = "eDP-1, 3840x2400@60, 0x0, auto, bitdepth, 10";

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;
    };

    decoration = {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      rounding = 10;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };

      drop_shadow = "yes";
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
    };

    "$mod" = "Alt";

    bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"

    ];

    binde = [ # allow press
        # resize horizontal stack
				"$mod, h, resizeactive, -20 0"
				"$mod, i, resizeactive, 20 0"

        # resize vertical stack
				"$mod Shift, h, resizeactive, 0 10"
				"$mod Shift, i, resizeactive, 0 -10"
    ];

    bind =
      [
        #"$mod, V, togglefloating"
        #"$mod, J, togglesplit"
        #"$mod, ENTER, layoutmsg,swapwithmaster master"
        #"$mod SHIFT, R, layoutmsg,rollnext"
        #"$mod, P, pseudo"
#        ", Print, exec, grimblast copy area"
#        #"$mod, h, movefocus, l"
#        #"$mod, i, movefocus, r"
#        "$mod, e, movefocus, u"
#        "$mod, n, movefocus, d"

        # Existing keybindings omitted for brevity...

        # Keybindings for managing the "master" layout
        "$mod, RETURN, exec, kitty --single-instance"
        "$mod, P, exec, pkill wofi || wofi --show=drun" # wofi launcher

        "$mod, Q, killactive" # kill current window
        "$mod Shift, Q, exit" # kill Hyprland

        #"$mod, F, exec, firefox"


        "$mod, R, togglespecialworkspace, spbtop" # Show spbtop scratchpad
        "$mod Shift, r, movetoworkspace, special:spbtop" # Move Window to scratchpad spbtop (in case of killing btop)

        "$mod, left, layoutmsg, orientationleft" # tile layout with master on left
        "$mod, right, layoutmsg, orientationright" # tile layout with master on right
        "$mod, down, layoutmsg, orientationcenter" # tile layout with master on center

        "$mod, u, layoutmsg, addmaster" # add focused window to master stack

        "$mod, bracketleft, changegroupactive, forward" # works only in monocle
        "$mod, bracketright, changegroupactive, back" # works only in monocle

        #"$mod, Backspace, exec, swaylock" # Lock the screen
        #"$mod Shift, Backspace, exec, wlogout --protocol layer-shell" # show the logout window

				"$mod, Print, exec, grim -t jpeg -q 90 -g \"$(slurp)\" - | swappy -f -" # take a screenshot

				"$mod, b, exec, killall -SIGUSR1 waybar" # Toggle the bar on and off
				"$mod Shift, b, exec, pkill waybar || waybar"

        # Window Management
        # Cycle focus to next window in stack
				"$mod, n, layoutmsg, cyclenext"  # works only in master
        # Swap focused window with next window in stack
				"$mod Shift, n, layoutmsg, swapnext" # works only in master

        # Cycle focus to previous window in stack
				"$mod, e, layoutmsg, cycleprev"   # works only in master
        # Swap focused window with previous window in stack
				"$mod Shift, e, layoutmsg, swapprev" # works only in master


        # focus master window
				"$mod, m, layoutmsg, focusmaster"
        # remove focused window from the master stack
				"$mod, d, layoutmsg, removemaster"

				"$mod, f, fullscreen"
				"$mod Shift, F, fakefullscreen"

				"$mod, g, togglegroup" # monocle

				"$mod, SPACE, layoutmsg, swapwithmaster auto"
				"$mod Shift, SPACE, togglefloating, # Allow a window to float"
				"$mod Shift, SPACE, centerwindow" # floating only

				"$mod, t, togglespecialworkspace, scratchpad"
				"$mod Shift, t, movetoworkspace, special:scratchpad"

				"$mod, s, togglespecialworkspace, spterm"
				"$mod Shift, s, movetoworkspace, special:spterm"

				"$mod, apostrophe, togglespecialworkspace, spcalc"
				"$mod Shift, apostrophe, movetoworkspace, special:spcalc"

				"$mod, Tab, cyclenext"
				"$mod, Tab, bringactivetotop" # works in floating mode 

        # Focus Monitor & Move Window to monitor
				"$mod, comma, focusmonitor, -1"
				"$mod Shift, comma, movewindow, mon:-1"

				"$mod, period, focusmonitor, +1"
				"$mod Shift, period, movewindow, mon:+1"

        # Switch workspaces with mainMod + [0-9]
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"
				"$mod, 5, workspace, 5"
				"$mod, 6, workspace, 6"
				"$mod, 7, workspace, 7"
				"$mod, 8, workspace, 8"
				"$mod, 9, workspace, 9"
				"$mod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mod Shift, 1, movetoworkspace, 1"
				"$mod Shift, 2, movetoworkspace, 2"
				"$mod Shift, 3, movetoworkspace, 3"
				"$mod Shift, 4, movetoworkspace, 4"
				"$mod Shift, 5, movetoworkspace, 5"
				"$mod Shift, 6, movetoworkspace, 6"
				"$mod Shift, 7, movetoworkspace, 7"
				"$mod Shift, 8, movetoworkspace, 8"
				"$mod Shift, 9, movetoworkspace, 9"
				"$mod Shift, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
				"$mod, mouse_down, workspace, e+1"
				"$mod, mouse_up, workspace, e-1"

#        "$mod, H, layoutmsg, shrinkmaster" # Shrink the master area
#        "$mod, L, layoutmsg, growmaster" # Grow the master area
#        "$mod, T, layoutmsg, togglefloat" # Toggle floating mode for the focused window
#        "$mod, Tab, layoutmsg, focusnext" # Move focus to the next window
#        "$mod Shift, Tab, layoutmsg, focusprev" # Move focus to the previous window
#        "$mod, Space, layoutmsg, swapmaster" # Swap the focused window with the master window
#
#        # Additional keybindings for workspace management and window focus
#        # These would remain largely the same as in your original configuration
#
#        "$mod, 1, workspace, 1"
#        "$mod, 2, workspace, 2"
#        "$mod, 3, workspace, 3"
#        "$mod, 4, workspace, 4"
#        "$mod, 5, workspace, 5"
#        "$mod, 6, workspace, 6"
#        "$mod, 7, workspace, 7"
#        "$mod, 8, workspace, 8"
#        "$mod, 9, workspace, 9"
#        "$mod, 0, workspace, 10"
#
#        "$mod SHIFT, 1, movetoworkspace, 1"
#        "$mod SHIFT, 2, movetoworkspace, 2"
#        "$mod SHIFT, 3, movetoworkspace, 3"
#        "$mod SHIFT, 4, movetoworkspace, 4"
#        "$mod SHIFT, 5, movetoworkspace, 5"
#        "$mod SHIFT, 6, movetoworkspace, 6"
#        "$mod SHIFT, 7, movetoworkspace, 7"
#        "$mod SHIFT, 8, movetoworkspace, 8"
#        "$mod SHIFT, 9, movetoworkspace, 9"
#        "$mod SHIFT, 0, movetoworkspace, 10"
      ]
      ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
            )
            10)
            );
          };
        };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
