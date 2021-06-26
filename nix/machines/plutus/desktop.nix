{ colors, lib, pkgs, ... }:
let
  inherit (lib.strings) floatToString;
  modifier = "Mod4";
  homeCfg = {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        inherit modifier;
        bars = [{ command = "waybar"; }];
        gaps = {
          outer = 4;
          inner = 4;
          smartGaps = true;
        };
        input = {
          "type:keyboard" = {
            repeat_delay = "150";
            repeat_rate = "30";
            xkb_layout = "us";
            xkb_variant = "intl";
          };
          "type:pointer" = {
            accel_profile = "adaptive";
            natural_scroll = "enabled";
          };
          "type:tablet_tool" = {
            map_from_region = let
              height = 0.265;
              width = height * 21 / 9;
            in "${floatToString (1 - width)}x0.0 1.0x${floatToString height}";
          };
        };
        keybindings = lib.mkOptionDefault {
          "${modifier}+Shift+s" =
            "exec GRIM_DEFAULT_DIR=~/Screenshots ${pkgs.grim}/bin/grim";
          "${modifier}+v" = "split toggle";
        };
        menu = ''
          ${pkgs.wofi}/bin/wofi \
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
          {
            command = ''
              swayidle -w \
                            timeout 300 'swaylock -f -c 000000' \
                            timout 600 'swaymsg \"output * dpms off\"' \
                            resume 'swaymsg \"output * dpms on\"' \
                            before-sleep 'swaylock -f -c 000000'
                          '';
          }
          { command = "exec mako"; }
        ];
        window = { hideEdgeBorders = "smart"; };
        workspaceAutoBackAndForth = true;
      };
    };
  };
in { home-manager.users.luiscm = homeCfg; }
