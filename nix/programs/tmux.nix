{ pkgs, ... }:
{
  enable = true;
  customPaneNavigationAndResize = true;
  disableConfirmationPrompt = true;
  escapeTime = 1;
  keyMode = "vi";
  newSession = true;
  terminal = "screen-256color";
}
