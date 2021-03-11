let
  mkColor = c: { xHex = "0x${c}"; plain = c; hex = "#${c}"; };
in rec {
  background = mkColor "282C34";
  foreground = mkColor "BBC2CF";

  normal = {
    black   = mkColor "1B2229";
    red     = mkColor "EC5F67";
    green   = mkColor "5FAF5F";
    yellow  = mkColor "D8A657";
    blue    = mkColor "51AFEF";
    magenta = mkColor "D16D9E";
    cyan    = mkColor "56B6C2";
    white   = mkColor "504945";
  };

  bright = {
    black   = mkColor "666660";
    red     = mkColor "EC5F67";
    green   = mkColor "5FAF5F";
    yellow  = mkColor "D8A657";
    blue    = mkColor "51AFEF";
    magenta = mkColor "D16D9E";
    cyan    = mkColor "56B6C2";
    white   = mkColor "BBC2CF";
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
