{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.dnscrypt-proxy2;
in {
  options.services.dnscrypt-proxy2 = {
    enable = mkEnableOption "dnscrypt-proxy2";

    package = mkOption {
      type = types.package;
      default = pkgs.dnscrypt-proxy2;
    };

    settings = mkOption {
      type = types.attrs;
      default = { };
    };

    configFile = mkOption {
      type = types.path;
      default = pkgs.runCommand "dnscrypt-proxy.toml" {
        json = builtins.toJSON cfg.settings;
        passAsFile = [ "json" ];
      } ''
        ${pkgs.remarshal}/bin/json2toml < $jsonPath > $out
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.dns = mkDefault [ "127.0.0.1" ];

    launchd.daemons.dnscrypt-proxy2 = {
      path = [ config.environment.systemPath ];

      serviceConfig = {
        ProgramArguments =
          [ "${cfg.package}/bin/dnscrypt-proxy" "-config" "${cfg.configFile}" ];
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Background";
        UserName = "root";
      };
    };
  };
}
