{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isAarch64;
in
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

    tmux

    #niri

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
    #jellyfin-media-player
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

    nchat

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
  ] ++ lib.optionals (!isAarch64) [
    appimage-run
    #clash-verge
  ];
}
