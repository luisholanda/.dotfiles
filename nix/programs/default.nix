super@{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isLinux;

  mkIfLinux = x: lib.mkIf isLinux x;
  colors = import ../config/colors.nix;
  args = super // { inherit colors; };
in {
  alacritty = import ./alacritty.nix args;
  firefox = import ./firefox args;
  fish = import ./fish.nix args;
  git = import ./git.nix args;
  gpg = import ./gpg.nix args;
  kitty = import ./kitty.nix args;
  mako = mkIfLinux (import ./mako.nix args);
  mpv = mkIfLinux (import ./mpv args);
  ssh = import ./ssh.nix args;
  tmux = import ./tmux.nix args;
  waybar = mkIfLinux (import ./waybar.nix args);

  bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
      italic-text = "always";
    };
  };

  brave = {
    enable = true;
    package = pkgs.brave;
  };

  fzf = rec {
    enable = true;

    changeDirWidgetCommand = "fd --type d";
    defaultCommand = fileWidgetCommand;
    fileWidgetCommand = "fd --type f";
  };

  go = rec {
    enable = false;
    goPath = ".gopath";
    goBin = "${goPath}/bin";
  };

  htop = {
    enable = true;
    settings = {
      cpu_count_from_zero = true;
      delay = 5;
      detailed_cpu_time = true;
      highlight_base_name = true;
      shadow_other_users = true;
      show_cpu_frequency = true;
      tree_view = true;
    };
  };

  neovim = {
    enable = true;
    extraConfig = ''lua require("init")'';
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
  };
}
