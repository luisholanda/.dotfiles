{ pkgs, ... }:
let
  home = builtins.getEnv "HOME";
in {
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile "${home}/.dotfiles/skhdrc";
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = rec {
      mouse_follows_focus = "on";
      focus_follows_mouse = "autoraise";
      window_placement = "second_child";
      window_topmost = "on";
      window_opacity = "on";
      window_shadow = "float";
      window_border = "off";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.98;
      split_ratio = 0.5;
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      window_gap = 4;
      top_padding = 4;
      bottom_padding = top_padding;
      left_padding = top_padding;
      right_padding = top_padding;
    };
  };
}
