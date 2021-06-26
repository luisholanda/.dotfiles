super@{ cfg, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux isDarwin;
  inherit (pkgs.lib) optionalString mkIf;
  applications = with pkgs; if isLinux
    then [ tdesktop nomacs pcmanfm texlab zathura minecraft osu-lazer ]
    else [];

  otherPackages = with pkgs; let
    gcpPkgs = [ cloud-sql-proxy google-cloud-sdk ];
    lspPkgs = [ nodePackages.pyright rnix-lsp terraform-lsp rust-analyzer nodePackages.typescript-language-server nodejs ];
  in [
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
      stateVersion = "21.03";
      sessionPath = [
        "$HOME/.pyenv/bin"
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
        "/run/current-system/sw/bin"
      ];

      sessionVariables = rec {
        MANPAGER = "nvim -c 'set ft=man' -";
        EDITOR = "nvim";
        GIT_SEQUENCE_EDITOR = EDITOR;
        CHROMIUM_FLAGS = optionalString isLinux "--enable-features=UseOzonePlatform --ozone-platform=wayland";
        SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
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
        ".config/brave-flags.conf".text = mkIf isLinux "--enable-features=UseOzonePlatform --ozone-platform=wayland";
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
