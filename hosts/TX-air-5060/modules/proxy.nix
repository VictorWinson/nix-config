{ ... }:
let
  # Pick ONE of these depending on what 192.168.3.61:1082 actually serves:
  #
  # If it's an HTTP proxy:
  # proxy = "http://192.168.3.61:1082";
  #
  # If it's a SOCKS5 proxy, use this instead (recommended if available):
   #proxy = "socks5h://192.168.3.61:1082";
   #proxy = "socks5h://192.168.1.3:1082";
in
{
  # System-wide proxy env (useful for many tools)
  networking.proxy.default = proxy;

  # Optional: extend bypass list (NixOS will set 127.0.0.1,localhost by default if null)
  networking.proxy.noProxy =
    "127.0.0.1,localhost,::1,192.168.0.0/16,10.0.0.0/8,.local";

  # Critical: ensure nix-daemon and its builders see the proxy variables
  systemd.services.nix-daemon.environment = {
    http_proxy  = proxy;
    https_proxy = proxy;
    all_proxy   = proxy;
    no_proxy    = "127.0.0.1,localhost,::1,192.168.0.0/16,10.0.0.0/8,.local";

    HTTP_PROXY  = proxy;
    HTTPS_PROXY = proxy;
    ALL_PROXY   = proxy;
    NO_PROXY    = "127.0.0.1,localhost,::1,192.168.0.0/16,10.0.0.0/8,.local";
  };
}

