{ config, pkgs, ... }:

with pkgs.myLib;
let
  defaultSettings = import ./settings.nix { inherit config; };
in {
  enable = true;
  package = pkgs.firefox;

  extensions =
    with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      multi-account-containers
      refined-github
      vim-vixen
      ublock-origin
    ];

  profiles = {
    home = {
      id = 0;

      settings = flattenAttrs defaultSettings;
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
