{ lib, pkgs, ... }:
{
  enable = false;
  settings = {
    font_family = "JetBrainsMono Nerd Font";
    font_size = 12;
    disable_ligatures = "cursor";
    scroll_back_lines = 3000;
    url_style = "single";
    copy_on_select = true;
    strip_trailing_spaces = "smart";
    focus_follows_mouse = true;
    repaint_delay = 3;
    enable_audio_bell = false;
    window_border_width = 2;
    window_padding_width = 2;
    hide_window_decorations = true;
    resize_draw_strategy = "scale";
    tab_bar_style = "separator";
    tab_separator = " |";
    tab_title_template = "{index}: {title}";
    update_check_interval = 0;
    macos_show_window_title_in = "menubar";
    kitty_mod = "ctrl+shift";
  };
}
