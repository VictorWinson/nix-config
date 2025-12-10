{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip

    jq
    yq-go
    eza
    pydf
    tealdeer
    cmake
    appimage-run

    tmux

    mtr
    iperf3
    dnsutils
    ldns
    socat
    nmap
    ipcalc
    rustscan

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

    gimp
    meh
    ffmpeg-full
    mpv
    pipewire
    pamixer
    exiftool
    mediainfo
    jellyfin-media-player
    xdg-desktop-portal
    wireplumber

    pandoc
    tectonic
    zathura
    ocrmypdf
    mupdf

    nix-output-monitor

    glow
    taskwarrior3
    taskwarrior-tui

    powertop
    btop
    iotop
    iftop
    bat
    neovide

    bluez
    blueman

    logiops

    #clash-verge

    nchat

    hmcl

    strace
    ltrace
    lsof

    acpi
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    fzf

    font-awesome
    wofi-emoji
    noto-fonts-monochrome-emoji
  ];
}
