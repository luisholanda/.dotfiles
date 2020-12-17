self: super:
let
  nativeCompRev = "fd9e9308d27138a16e2e93417bd7ad4448fea40a";
  fetchHomebrewEmacsPlusPatch = { patch, sha256 }: builtins.fetchurl {
    url = "https://github.com/d12frosted/homebrew-emacs-plus/raw/master/patches/emacs-28/${patch}.patch";
    inherit sha256;
  };
  homebrewPatches = map fetchHomebrewEmacsPlusPatch [
    { patch = "fix-window-role"; sha256 = "0c41rgpi19vr9ai740g09lka3nkjk48ppqyqdnncjrkfgvm2710z"; }
    { patch = "system-appearance"; sha256 = "1100dy6i12gwa41zr5s41qmydi6jynh84gsraidy8w9ii7i43d92"; }
    { patch = "no-titlebar"; sha256 = "02lc92jflpn4mzxh242s2ws9lwqhngk19rjkiw8xh6q3w2qgj2lr"; }
  ];
in {
  gccemacs = (super.emacs.override {
    srcRepo = true;
    nativeComp = true;
  }).overrideAttrs (old: {
    version = "gccemacs-28";
    src = super.fetchFromGitHub {
      owner = "emacs-mirror";
      repo = "emacs";
      rev = nativeCompRev;
      sha256 = "1z1qmxarszkxwkdwhzqc0c39j762hbivbichjm9zwgggyjx95bj4";
    };

    NATIVE_FULL_AOT = 1;

    hiresSrc = builtins.fetchurl {
      url = "ftp://ftp.math.s.chiba-u.ac.jp/emacs/emacs-hires-icons-3.0.tar.gz";
      sha256 = "0f2wzdw2a3ac581322b2y79rlj3c9f33ddrq9allj97r1si6v5xk";
    };

    postUnpack = ''
      tar xzfv $hiresSrc --strip 1 -C $sourceRoot
    '';

    patches = homebrewPatches;
    postPatch = old.postPatch + ''
      substituteInPlace lisp/loadup.el \
      --replace '(emacs-repository-get-version)' '"${nativeCompRev}"' \
      --replace '(emacs-repository-get-branch)' '"feature/native-comp"'

      substituteInPlace lisp/international/mule-cmds.el \
        --replace /usr/share/locale ${super.gettext}/share/locale

      # use newer emacs icon
      cp nextstep/Cocoa/Emacs.base/Contents/Resources/Emacs.icns mac/Emacs.app/Contents/Resources/Emacs.icns

      # Fix sandbox impurities
      substituteInPlace Makefile.in --replace '/bin/pwd' 'pwd'
      substituteInPlace lib-src/Makefile.in --replace '/bin/pwd' 'pwd'
    '';

    configureFlags = old.configureFlags ++ [
      "--with-mac"
      "--enable-mac-app=$$out/Applications"
    ];
  });
}
