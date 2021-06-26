super@{ colors, ... }: {
  enable = true;
  maxVisible = 3;
  layer = "overlay";
  font = "Noto Sans 10";
  backgroundColor = colors.background.hex;
  textColor = colors.foreground.hex;
  borderSize = 0;
  progressColor = "over ${colors.normal.blue.hex}";
  defaultTimeout = 3 * 1000;
  width = 500;
}
