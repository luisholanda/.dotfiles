super:
{
  imports = [
    ./fish.nix
    ./git.nix
  ];

  programs.fzf = rec {
    enable = true;

    changeDirWidgetCommand = "fd --type d";
    defaultCommand = fileWidgetCommand;
    fileWidgetCommand = "fd --type f";
  };

  programs.go = rec {
    enable = true;
    goPath = ".gopath";
    goBin = "${goPath}/bin";
  };

  programs.gpg = {
    enable = true;
    settings = rec {
      default-key = "E88FEEF182345568289945A7DA2223669494475C";
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = cert-digest-algo;
      s2k-cipher-algo = "AES256";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = list-options;
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      throw-keyids = true;
      use-agent = true;
      auto-key-retrieve = true;
    };
  };

  programs.htop = {
    enable = true;
    cpuCountFromZero = true;
    delay = 5;
    detailedCpuTime = true;
    highlightBaseName = true;
    shadowOtherUsers = true;
    showCpuFrequency = true;
    treeView = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython = false;
  };
}
