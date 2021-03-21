super@{ cfg, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux isDarwin;
  inherit (pkgs.lib) optionalString mkIf;
  applications = with pkgs; if isLinux
    then [ tdesktop osu-lazer obs-studio ]
    else [];

  otherPackages = with pkgs; let
    gcpPkgs = [ cloud-sql-proxy unstable.google-cloud-sdk ];
    lspPkgs = [ unstable.nodePackages.pyright rnix-lsp terraform-lsp rust-analyzer ];
  in [
    any-nix-shell
    devicon-lookup
    exa
    fishPlugins.foreign-env
    gitAndTools.gh
    git.doc
    httpie
    jq
    nixfmt
    ripgrep
    yarn
    protobuf
  ] ++ gcpPkgs
  ++ lspPkgs
  ++ (import ./scripts.nix super);

  username = "luiscm";
  myHomeConfig = {
    programs = import ../programs super // {
      home-manager.enable = true;
    };

    home = {
      packages = otherPackages ++ applications;
      stateVersion = "20.09";
      sessionPath = [
        "$HOME/.pyenv/bin"
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
        "/run/current-system/sw/bin"
      ];

      sessionVariables = {
        MANPAGER = "nvim -c 'set ft=man' -";
        EDITOR = "nvim";
        CHROMIUM_FLAGS = optionalString isLinux "--use-gl=desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
      };

      file = {
        doomConfig = {
          source = ../../doom;
          target = ".config/doom";
        };
        kakouneConfig = {
          source = ../../kakrc;
          target = ".config/kak";
        };
        neovimConfig = {
          source = ../../nvim;
          target = ".config/nvim";
          # Prevent that we add generated files to git.
          recursive = true;
        };
        ".config/brave-flags.conf".text = mkIf isLinux "--use-gl=desktop  --enable-features=UseOzonePlatform --ozone-platform=wayland";
        ".confg/obs-studio/plugins/wlrobs".source = mkIf isLinux "${pkgs.obs-wlrobs}/share/obs/obs-plugins/wlrobs";
        ".confg/obs-studio/plugins/v4l2sink".source = mkIf isLinux "${pkgs.obs-v4l2sink}/share/obs/obs-plugins/v4l2sink";
      };
    };

    xdg = lib.mkIf isLinux {
      enable = true;
      userDirs.enable = true;
    };
  };
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.luiscm = myHomeConfig;
    verbose = true;
  };
}
