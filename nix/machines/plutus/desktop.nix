{ colors, pkgs, ... }:
let
  modifier = "Mod4";
  homeCfg = {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        inherit modifier;
        gaps = {
          outer = 4;
          inner = 4;
          smartGaps = true;
        };
        input = {
          "type:keyboard" = {
            repeat_delay = "150";
            repeat_rate = "25";
          };
          "type:pointer" = {
            accel_profile = "adaptive";
            natural_scroll = "enabled";
          };
        };
        menu = ''${pkgs.wofi}/bin/wofi \
          --normal-window \
          --gtk-dark \
          --insensitive \
          --maching=fuzzy \
          --hide-scroll \
          --allow-markup \
          --allow-images \
          --show run \
          --fork
        '';
        terminal = "${pkgs.alacritty}/bin/alacritty";
        startup = [
          { command = ''swayidle -w \
              timeout 300 'swaylock -f -c 000000' \
              timout 600 'swaymsg \"output * dpms off\"' \
              resume 'swaymsg \"output * dpms on\"' \
              before-sleep 'swaylock -f -c 000000'
            '';
          }
        ];
        window = {
          hideEdgeBorders = "smart";
        };
        workspaceAutoBackAndForth = true;
      };
    };
  };
in {
  home-manager.users.luiscm = homeCfg;
}
