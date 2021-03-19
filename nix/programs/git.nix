{ lib, pkgs, ... }:

rec {
  enable = true;
  package = pkgs.git;
  userName = "Luis Holanda";
  userEmail = "luiscmholanda@gmail.com";
  signing.key = "DA2223669494475C";
  signing.signByDefault = true;

  delta = {
    enable = true;
    options = {
      line-numbers = true;
      syntax-theme = "OneHalfDark";
    };
  };

  extraConfig = {
    core = {
      commentChar = "@";
      sshCommand = "ssh -i ~/.ssh/github";
    };
    credential = { helper = "osxkeychain"; };
    color = { ui = true; };
    branch = { autosetuprebase = "always"; };
    pull = { rebase = true; };
    url = { "git@github.com:" = { insteadOf = "https://github.com/"; }; };
  };

  aliases = {
    # list all aliases
    aliases =
      "!git config --get-regexp '^alias\\.' | cut -c 7- | sed 's/ / = /'";

    # list all tags
    tags = "tag -n1 --list";
    # list all stashes
    stashes = "stash list";
    # fix dumb mistakes
    fuck = "!git add :/*; git cane; git sync -f";
    # status with short format instead of full details
    ss = "status --short";
    # status with short format and showing branch and tracking info.
    ssb = "status --short --branch";
    # list all branches, remotes included.
    branches = "branch -a";
    # create a new branch.
    nb = "checkout -b";
    # checkout to a branch.
    ch = "checkout";

    # sync to remove
    sync = ''!git push origin "$(git rev-parse --abbrev-ref HEAD)"'';
    # update branch with base branch.
    upwb = ''
      !git pull origin develop --rebase && git push origin "$(git rev-parse --abbrev-ref HEAD)" --force'';

    # cherry-pick
    cp = "cherry-pick";
    cpc = "cp --continue";
    cpa = "cp --abort";

    # commit
    co = "commit";
    # commit with inline message
    cm = "co --message";
    # commit - amend the tip of the current branch rather than creating
    # a new commit
    ca = "co --amend";
    # commit - amend the tip of the current branch with inline message
    cam = "ca --message";
    # commit - amend the tip of the current branch, and do not edit the message
    cane = "ca --no-edit";
    # commit interactive
    ci = "co --interactive";

    df = "diff";
    # diff - show changes not yet staged
    dc = "df --cached";
    # diff - show changes about to be commited
    ds = "df --staged";
    dh = "df HEAD";
    # diff - show changes by word, not line
    dw = "!git diff --word-diff";

    # diff deep
    dd =
      "diff --check --dirstat --find-copies --find-renames --histogram --color";

    # log with a text-based graphical representation of the commit history.
    lg = "log --graph";
    # log with one line per item.
    lo = "log --oneline";
    # log with patch generation.
    lp = "log --patch";
    # log with first-parent, useful for team branch that only accepts
    # pull requests.
    lfp = "log --first-parent";
    # log with items appearing in topological order, i.e. descedant commits
    # are show before their parents.
    lt = "log --topo-order";
    ll =
      "log --graph --topo-order --date=short --abbrev-commit --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
    lll =
      "log --graph --topo-order --date=iso8601-strict --no-abbrev-commit --abbrev=40 --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn <%ce>]%Creset %Cblue%G?%Creset'";

    # rebase - forward-port local commits to the updated upstream head.
    rb = "rebase";
    # iterative rebases using the provided number of commits.
    rbi = "rb --interactive";
    # rebase abort - cancel the rebasing process.
    rba = "rb --abort";
    # rebase - continue the rebasing process after resolving a conflict
    # manually and updating the index with the resolution.,
    rbc = "rb --continue";
    # rebase - restart the rebasing process by skipping the current patch.
    rbs = "rb --skip";

    save = if package.version < "2.16.0" then "stash save -u" else "stash push -u";
    pop = "stash pop";
    snapshot =
      "!git save \"snapshot: $(date)\" && git stash apply 'stash@{0}'";

    # pruner: prune everything that is unreachable now.
    #
    # This command taskes a long time to run, perhaps even overnight.
    # This is useful for removing unreachable objects from all places,
    # reducing the total repository size.
    #
    #By [CodeGnome](http://www.codegnome.com/)
    pruner =
      "!git prune --expire=now && git reflog expire --expire-unreachable=now --rewrite --all && git fetch --prune";

    # repacker: repack a repo the way Linus recommends.
    #
    # This command takes a long time to run, perhaps even overnight.
    #
    # It does the equivalent of "git gc --aggressive" but done *properly*,
    # which is to do something like:
    #
    #     git repack -a -d --depth=250 --window=250
    #
    # The depth setting is about how deep the delta chains can be; make
    # them longer for old history - it's worth the space overhead.
    #
    # The window setting is about how big an object window we want each
    # delta candidate to scan.
    #
    # And here, you might well want to add the "-f" flag (which is the
    # "drop all old deltas"), since you now are actually trying to make
    # sure that this one actually finds good candidates.
    #
    # And then it's going to tkae forever and a day (i.e. a "do it overnight"
    # thing), but the end result is that everybody downstream from that
    # repository will get much better packs, without having to spend any
    # effort on it themselves.
    #
    # http://metalinguist.wordpress.com/2007/12/06/the-woes-of-git-gc-aggressive-and-how-git-deltas-work/
    #
    # We also add the --window-memory limit of 1G, which helps protect
    # us from a window that has very large objects such as binary blobs.

    repacker = "repack -a -d -f --depth=300 --window=300 --window-memory=1g";

    optimize = "!git pruner && git repacker";

    # create a new pull request for this branch on GitHub.
    prc = "!gh pr create -w";
  };

  ignores = lib.optionals pkgs.stdenv.isDarwin [
    # General
    ".DS_Store"
    ".AppleDouble"
    ".LSOverride"
    "Icon"
    # Files that might appear in the root of a volume
    ".DocumentRevisions-V100"
    ".fseventsd"
    ".Spotlight-V100"
    ".TemporaryItems"
    ".Trashes"
    ".VolumeIcon.icns"
    ".com.apple.timemachine.donotpresent"
    # Directories potentially created on remote AFP share
    ".AppleDB"
    ".AppleDesktop"
    "Network Trash Folder"
    "Temporary Items"
    ".apdisk"
  ];
}
