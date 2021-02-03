{ pkgs, ... }:

let channels = import ../channels;
in {
  enable = true;
  interactiveShellInit = ''
    set -g fish_key_bindings fish_user_keybindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    source (pyenv init -|psub)
    source (pyenv virtualenv-init -|psub)
  '';
  loginShellInit = ''
    set -p fish_function_path ${pkgs.fish-foreign-env}/share/fish-foreign-env/functions
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

    set -p NIX_PATH ${builtins.concatStringsSep " " channels.nixPathStr}
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
        set --local projects_dirs ~/TerraMagna/repositories ~/Projects

        for proj_dir in $projects_dirs
          if test -d $proj_dir/$project
            cd $proj_dir/$project

            if test -d ~/.pyenv/version/$project
              pyenv activate $project
            end

            if test -f $proj_dir/$project/shell.nix
              nix-shell
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
        rev = "d66aa7f0fec5555144d29faec34a4e7eff7af32b";
        sha256 = "0klcwlgsn6nr711syshrdqgjy8yd3m9kxakfzv94jvcnayl0h62w";
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
