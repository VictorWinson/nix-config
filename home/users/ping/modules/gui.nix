{ pkgs, ... }:
{
  programs.obs-studio.enable = true;

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

  programs.firefox.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "nerd-fonts-source-code-pro, noto-emoji";
      size = 18;
    };
    shellIntegration.enableZshIntegration = true;
    #themeFile = "${pkgs.kitty-themes}/share/kitty-themes/themes/Corvine.conf";
    theme = "Corvine";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
  };

  programs.wezterm = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        output = [ "eDP-1" "HDMI-A-1" ];
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [];
        modules-right = [ "backlight" "cpu" "memory" "pulseaudio" "network" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
          active-only = true;
        };

        cpu.interval = 5;
        memory.interval = 5;

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
      };
    };
  };

  programs.alacritty = {
    enable = false;
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
    enable = true;
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

        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      "$mod" = "Alt";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        "$mod, h, resizeactive, -20 0"
        "$mod, i, resizeactive, 20 0"
        "$mod Shift, h, resizeactive, 0 10"
        "$mod Shift, i, resizeactive, 0 -10"
      ];

      bind =
        [
          "$mod, RETURN, exec, kitty --single-instance --detach --hold $SHELL -l"
          "$mod, P, exec, pkill wofi || wofi --show=drun"

          "$mod, Q, killactive"
          "$mod Shift, Q, exit"

          "$mod, R, togglespecialworkspace, spbtop"
          "$mod Shift, r, movetoworkspace, special:spbtop"

          "$mod, left, layoutmsg, orientationleft"
          "$mod, right, layoutmsg, orientationright"
          "$mod, down, layoutmsg, orientationcenter"

          "$mod, u, layoutmsg, addmaster"

          "$mod, bracketleft, changegroupactive, forward"
          "$mod, bracketright, changegroupactive, back"

          "$mod, Print, exec, grim -t jpeg -q 90 -g \"$(slurp)\" - | swappy -f -"

          "$mod, b, exec, killall -SIGUSR1 waybar"
          "$mod Shift, b, exec, pkill waybar || waybar"

          "$mod, n, layoutmsg, cyclenext"
          "$mod Shift, n, layoutmsg, swapnext"

          "$mod, e, layoutmsg, cycleprev"
          "$mod Shift, e, layoutmsg, swapprev"

          "$mod, m, layoutmsg, focusmaster"
          "$mod, d, layoutmsg, removemaster"

          "$mod, f, fullscreen, 0"
          "$mod Shift, F, fullscreenstate, 1"

          "$mod, g, togglegroup"

          "$mod, SPACE, layoutmsg, swapwithmaster auto"
          "$mod Shift, SPACE, togglefloating"
          "$mod Shift, SPACE, centerwindow"

          "$mod, t, togglespecialworkspace, scratchpad"
          "$mod Shift, t, movetoworkspace, special:scratchpad"

          "$mod, s, togglespecialworkspace, spterm"
          "$mod Shift, s, movetoworkspace, special:spterm"

          "$mod, apostrophe, togglespecialworkspace, spcalc"
          "$mod Shift, apostrophe, movetoworkspace, special:spcalc"

          "$mod, Tab, cyclenext"
          "$mod, Tab, bringactivetotop"

          "$mod, comma, focusmonitor, -1"
          "$mod Shift, comma, movewindow, mon:-1"

          "$mod, period, focusmonitor, +1"
          "$mod Shift, period, movewindow, mon:+1"

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

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
            x:
              let
                c = (x + 1) / 10;
                ws = builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
          ) 10)
        );
    };
  };
}
