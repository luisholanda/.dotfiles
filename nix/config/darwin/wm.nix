{ config, pkgs, lib, ... }:
let home = builtins.getEnv "HOME";
in {
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile "${home}/.dotfiles/skhdrc";
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "top";
      height = 24;
      spacing_left = 24;
      spacing_right = 15;
      text_font = ''".SF NS Display:Regular:13.0"'';
      icon_font = ''"JetBrainsMono Nerd Font:Regular:13.0"'';
      background_color = "0xff202020";
      foreground_color = "0xffa8a8a8";
      space_icon_color = "0xff458588";
      power_icon_color = "0xffcd950c";
      battery_icon_color = "0xffd75f5f";
      dnd_icon_color = "0xffa8a8a8";
      clock_icon_color = "0xffa8a8a8";
      clock_format = ''"%a %d %b %I:%M %p"'';
    };
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
      external_bar = "all:24:0";
    };
  };
}
