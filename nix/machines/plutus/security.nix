super:
{
  networking.firewall.allowPing = false;

  security.doas = {
    enable = true;
    extraRules =
      [ { users = [ "luiscm" ]; persist = true; }
        { users = [ "luiscm" ];
          cmd = "/run/current-system/sw/bin/nixos-rebuild";
          noPass = true;
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
