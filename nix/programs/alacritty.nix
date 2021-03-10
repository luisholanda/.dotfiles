super@{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  enable = true;
  package = pkgs.alacritty;
  settings = let
    xy = x: y: { inherit x y; };
  in {
    colors = {
      primary = {
          background = "0x282C34";
          foreground = "0xBBC2CF";
      };

      normal = {
        black = "0x1B2229";
        red = "0xEC5F67";
        green = "0x5FAF5F";
        yellow = "0xD8A657";
        blue = "0x51AFEF";
        magenta = "0xD16D9E";
        cyan = "0x56B6C2";
        white = "0x504945";
      };

      bright = {
        black = "0x666660";
        red = "0xEC5F67";
        green = "0x5FAF5F";
        yellow = "0xD8A657";
        blue = "0x51AFEF";
        magenta = "0xD16D9E";
        cyan = "0x56B6C2";
        white = "0xBBC2CF";
      };
    };
    draw_bold_text_with_bright_colors = true;

    env.TERM = "screen-256color";

    font = let
      family = "JetBrainsMono Nerd Font Mono";
      fontWithStyle = style: { inherit family style; };
    in {
      normal = fontWithStyle "Regular";
      bold = fontWithStyle "Bold";
      italic = fontWithStyle "Italic";
      bold_italic = fontWithStyle "Bold Italic";

      size = 14;

      # External monitors aren't retina, for now ;)
      use_thin_strokes = false;
    };

    live_config_reload = true;
    mouse.hide_when_typing = true;
    selection.save_to_clipboard = true;

    window = {
      decorations = if isDarwin then "buttonless" else "None";
      dimensions = { columns = 120; lines = 48; };
      dynamic_title = false;
      dynamic_padding = true;
      startup_mode = "Maximized";
      padding = xy 4 4;
    };
  };
}
