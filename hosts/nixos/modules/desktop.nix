{ pkgs, ... }:
{
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      #intel-media-driver
      #intel-vaapi-driver
      libva-vdpau-driver #vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      font-awesome
      noto-fonts
      source-han-sans
      source-han-serif
      source-code-pro
      nerd-fonts
      jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Noto Sans Mono CJK SC"
        "Sarasa Mono SC"
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Source Han Sans SC"
        "DejaVu Sans"
      ];
      serif = [
        "Noto Serif CJK SC"
        "Source Han Serif SC"
        "DejaVu Serif"
      ];
    };
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "colemak";
  };

  programs.hyprland.enable = false;
}
