super:
{
  security.doas = {
    enable = true;
    extraRules =
      [ { users = [ "luiscm" ]; persist = true; }
        { users = [ "luiscm" ];
          cmd = "/run/current-system/sw/bin/nixos-rebuild";
          args = [ "switch" ];
          setEnv = ["$NIX_PATH"];
          noPass = true;
        }
        { users = [ "luiscm" ];
          cmd = "/run/current-system/sw/bin/nixos-rebuild";
          args = [ "switch" "--rollback" ];
          setEnv = ["$NIX_PATH"];
          noPass = false;
        }
        { users = [ "luiscm" ];
          cmd = "/run/current-system/sw/bin/nix-collect-garbage";
          persist = false;
        }
      ];
  };

  security.protectKernelImage = true;
  security.rtkit.enable = true;
  security.sudo.enable = false;
}
