{ config, pkgs, ... }:
let
  home = config.users.users.luiscm.home;
in {
  enable = true;
  forwardAgent = true;
  compression = true;
  serverAliveInterval = 30;
  serverAliveCountMax = 5;
  hashKnownHosts = true;
  matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "${home}/.ssh/github";
      extraOptions = {
        PreferredAuthentications = "publickey";
        IgnoreUnknown = "UseKeychain";
        UseKeychain = "yes";
        AddKeysToAgent = "yes";
      };
    };
  };
}
