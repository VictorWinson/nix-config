{ pkgs, ... }:
{
    hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
    };
  };

  systemd.user.services.blueman-applet = {
    description = "Blueman tray applet";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session-pre.target" "bluetooth.target" ];
    path = with pkgs; [ blueman bluez ];

    serviceConfig = {
      ExecStart = "${pkgs.blueman}/bin/blueman-applet";
      Restart = "on-failure";
    };
  };

  services.blueman.enable = true;
  programs.dconf.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      #intel-media-driver
      #intel-vaapi-driver
      libva-vdpau-driver #vaapiVdpau
      libvdpau-va-gl
    ];
  };

  services.asusd.enable = true;
  services.supergfxd.enable = true;
  environment.systemPackages = with pkgs; [ asusctl supergfxctl ];

  systemd.services.supergfxd.path = with pkgs; [ kmod pciutils ];

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Optional driver choice (default is stable):
    # package = config.boot.kernelPackages.nvidiaPackages.production;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:0:66:0";
      nvidiaBusId = "PCI:0:64:0";
    };
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
      nerd-fonts.jetbrains-mono
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
}
