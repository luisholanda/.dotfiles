super@{ colors, pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  enable = true;
  package = pkgs.unstable.alacritty;
  settings = let
    xy = x: y: { inherit x y; };
  in {
    colors = {
      primary = {
          background = colors.background.xHex;
          foreground = colors.foreground.xHex;
      };

      normal = {
        black = colors.normal.black.xHex;
        red = colors.normal.red.xHex;
        green = colors.normal.green.xHex;
        yellow = colors.normal.yellow.xHex;
        blue = colors.normal.blue.xHex;
        magenta = colors.normal.magenta.xHex;
        cyan = colors.normal.cyan.xHex;
        white = colors.normal.white.xHex;
      };

      bright = {
        black = colors.bright.black.xHex;
        red = colors.bright.red.xHex;
        green = colors.bright.green.xHex;
        yellow = colors.bright.yellow.xHex;
        blue = colors.bright.blue.xHex;
        magenta = colors.bright.magenta.xHex;
        cyan = colors.bright.cyan.xHex;
        white = colors.bright.white.xHex;
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

      size = 10;

      # External monitors aren't retina, for now ;)
      use_thin_strokes = false;
    };

    live_config_reload = true;
    mouse.hide_when_typing = false;
    selection.save_to_clipboard = true;

    window = {
      decorations = if isDarwin then "buttonless" else "none";
      dimensions = { columns = 120; lines = 48; };
      dynamic_title = false;
      dynamic_padding = true;
      startup_mode = "Maximized";
      padding = xy 4 4;
    };
  };
}
