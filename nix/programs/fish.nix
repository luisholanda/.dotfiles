{ pkgs, ... }:

{
  programs.fish = {
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

    set -p NIX_PATH darwin-config=$HOME/.nixpkgs/darwin-configuration.nix
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
  };
  functions = {
    fish_user_keybindings = ''
      fish_default_key_bindings -M insert
      fish_vi_key_bindings default
    '';
    workon = {
      argumentNames = "project";
      description = "Goto the given project";
      body = ''
        set --local projects_dirs = ~/TerraMagan/repositories ~Projects
        for proj_dir in project_dirs
          if test -d $proj_dir/$project
            cd $proj_dir/$project

            if test -d ~/.pyenv/version/$project
              pyenv activate $project
            end
          end
        end

        echo "Project $project not found"
        return 1
      '';
    };
  };
  plugins = [
    {
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "rafaelrinaldi";
        repo = "pure";
        rev = "d66aa7f0fec5555144d29faec34a4e7eff7af32b";
        sha256 = "0klcwlgsn6nr711syshrdqgjy8yd3m9kxakfzv94jvcnayl0h62w";
      };
    }
  ];
};
}
