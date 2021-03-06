self: super:
let
  kernel = self.linuxPackages_5_10.kernel;
  modDestDir =
    "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8188eu";
in {
  firmware-rtl8188eu = self.stdenv.mkDerivation rec {
    name = "rtl8188eu-${kernel.version}-${version}";
    version = "b02c92b";

    src = self.fetchgit {
      url = "https://github.com/lwfinger/rtl8188eu.git";
      rev = "6d74135f34d3d4d521ae5bc000d3788b219dbd8c";
      sha256 = "1xl3vzsg14r50j6l9b6xfa6zn7bhs2wlg034vcfm3q6mx6j9csrj";
      leaveDotGit = true;
    };

    hardeningDisable = [ "pic" ];

    nativeBuildInputs = kernel.moduleBuildDependencies;
    buildInputs = [ self.bc ];

    makeFlags = [ "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

    enableParallelBuilding = true;

    installPhase = ''
      mkdir -p ${modDestDir}
      find . -name '*.ko' -exec cp --parents {} ${modDestDir} \;
      find ${modDestDir} -name '*.ko' -exec xz -f {} \;
      # mkdir -p $out/lib/firmware/rtlwifi
      # install -D -pm644 rtl8188eufw.bin $out/lib/firmware/rtlwifi/rtl8188eufw.bin
    '';

    meta = {
      description = "Realtek rtl8188eu driver";
      homepage = "https://github.com/lwfinger/rtl8188eu";
      license = self.lib.licenses.gpl2;
      platforms = self.lib.platforms.linux;
    };
  };
}
