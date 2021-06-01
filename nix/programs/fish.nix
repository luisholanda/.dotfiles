{ pkgs, config, ... }:

let nixPath = config.nix.nixPath;
in {
  enable = true;
  interactiveShellInit = ''
    set -g fish_key_bindings fish_user_keybindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    _pure_set_default pure_show_prefix_root_prompt true
    set_color pure_color_mute white

    set --prepend fish_function_path /nix/store/mwhwbzvdf32hmnfkid34k2cjnajvp6qv-fishplugin-foreign-env-git-20200209/share/fish/vendor_functions.d
    set -e __HM_SESS_VARS_SOURCED
    fenv source /etc/profiles/per-user/luiscm/etc/profile.d/hm-session-vars.sh > /dev/null
    set -e fish_function_path[1]
  '';
  loginShellInit = ''
    set -p fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d
    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    end

    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fenv source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    end

    if test -e /etc/static/fish/config.fish
      source /etc/static/fish/config.fish
    end
    set -e fish_function_path[1]

    set -e NIX_PATH
    set -x NIX_PATH ${builtins.concatStringsSep " " nixPath}

    if test (tty) = "/dev/tty0"
      exec sway
    end
  '';
  promptInit = ''
    any-nix-shell fish --info-right | source
  '';
  shellAliases = rec {
    grep = "grep --color";
    sgrep = "grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}";
    vim = "nvim";
    cat = "bat";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    rm = "rm -i";
    cp = "cp -i";
    mv = "mv -i";

    ls = "exa";
    ll = "${ls} -lh";
    la = "${ls} -a";
    lla = "${ls} -lha";
    lt = "${ls} --tree";

    gt = "git";
    mk = "make";

    cdot = "cd ~/.dotfiles";
    nix-rbld = "darwin-rebuild switch";
    nix-gc = "nix-collect-garbage -d";
    nix-opt = "nix-store --optimise";
  };
  functions = {
    fish_user_keybindings = ''
      fish_default_key_bindings -M insert
      fish_vi_key_bindings default

      set -U pisces_pairs '(,)' '[,]' '{,}' '","' "','"

      for pair in $pisces_pairs
        _pisces_bind_pair insert (string split -- ',' $pair)
      end

      # normal backspace, also known as \010 or ^H:
      bind -M insert \b _pisces_backspace
      # Terminal.app sends DEL code on ?:
      bind -M insert \177 _pisces_backspace

      # overrides TAB to provide completion of vars before a closing '"'
      bind -M insert \t _pisces_complete
    '';
    workon = {
      argumentNames = "project";
      description = "Go to the given project";
      body = ''
        set --local prev_dir (pwd)
        set --local projects_dirs ~/TerraMagna/repositories ~/Projects

        for proj_dir in $projects_dirs
          if test -d $proj_dir/$project
            set --local project_dir $proj_dir/$project
            cd $project_dir

            if test -d ~/.pyenv/version/$project
              pyenv activate $project
            end

            if test -f $project_dir/shell.nix
              nix-shell
            end

            function __on_exit --on-event fish_exit --inherit-variable prev_dir
              cd $prev_dir
            end

            return 0
          end
        end

        echo "Project $project not found"
        return 1
      '';
    };
    local-psql = {
      argumentNames = "action";
      description = "Start or stop local PostgreSQL instance";
      body = ''
        env PGPORT=5432 pg_ctl -D /usr/local/var/postgres -l /tmp/logfile $action > /dev/null 2>&1
      '';
    };
  };
  plugins = [
    rec {
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "rafaelrinaldi";
        repo = name;
        rev = "69e9a074125ad853aae244ce2aabc33811b99970";
        sha256 = "1x1h65l8582p7h7w5986sc9vfd7b88a7hsi68dbikm090gz8nlxx";
      };
    }
    rec {
      name = "pisces";
      src = pkgs.fetchFromGitHub {
        owner = "laughedelic";
        repo = name;
        rev = "34971b9671e217cfba0c71964f5028d44b58be8c";
        sha256 = "05wjq7v0v5hciqa27wx2xypyywa4291pxmmvfv5yvwmxm1pc02hm";
      };
    }
  ];
}
