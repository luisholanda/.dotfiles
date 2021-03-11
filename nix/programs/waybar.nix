{ colors, pkgs, ... }:
{
  enable = true;
  package = pkgs.waybar;
  settings = [{
    layer = "top";
    height = 24;
    position = "top";
    output = ["HDMI-A-1"];
    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ "sway/window" ];
    modules-right = [ "network" "cpu" "memory" "pulseaudio" "clock" "tray" ];
    modules = {
      cpu = {
        interval = 10;
        format = "{}% ";
      };
      clock = {
        interval = 60;
        format = "{:%a %d %b %I %M %p}";
      };
      memory = {
        format = "{used:0.1f}G/{total:0.1f}G ";
      };
      network = {
        interface = "wlp0s20f0u2";
        format = "{ifname}";
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ifname} ";
        format-disconnected = "";
        tooltip-format = "{ifname}";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        tooltip-format-ethernet = "{ifname} ";
        tooltip-format-disconnected = "Disconnected";
      };
      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" ""];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
      };
      "sway/mode" = {
        format = " {}";
        max-length = 50;
      };
      "sway/window" = {
        max-length = 88;
      };
      tray = {
        icon-size = 21;
        spacing = 8;
      };
    };
  }];
}
