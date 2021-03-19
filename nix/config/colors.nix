let
  inherit (builtins) substring stringLength;
  mkColor = hex: let
      plain = substring 1 (stringLength hex) hex;
  in { inherit hex plain; xHex = "0x${plain}"; };
in rec {
  background = mkColor "#2B2D3A";
  foreground = mkColor "#E1E3E4";
  normal = {
    black   = mkColor "#181A1C";
    red     = mkColor "#FB617E";
    green   = mkColor "#9ED06C";
    yellow  = mkColor "#EDC763";
    blue    = mkColor "#6DCAE8";
    magenta = mkColor "#BB97EE";
    cyan    = mkColor "#F89860";
    white   = mkColor "#E1E3E4";
  };

  bright = {
    black   = mkColor "#181A1C";
    red     = mkColor "#FB617E";
    green   = mkColor "#9ED06C";
    yellow  = mkColor "#EDC763";
    blue    = mkColor "#6DCAE8";
    magenta = mkColor "#BB97EE";
    cyan    = mkColor "#F89860";
    white   = mkColor "#E1E3E4";
  };

  term = [
    normal.black.plain
    normal.red.plain
    normal.green.plain
    normal.yellow.plain
    normal.blue.plain
    normal.magenta.plain
    normal.cyan.plain
    normal.white.plain
    bright.black.plain
    bright.red.plain
    bright.green.plain
    bright.yellow.plain
    bright.blue.plain
    bright.magenta.plain
    bright.cyan.plain
    bright.white.plain
  ];
}
