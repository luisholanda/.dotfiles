super: {
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "luiscm" ];
      persist = true;
      keepEnv = true;
    }];
  };

  security.protectKernelImage = true;
  security.rtkit.enable = true;
  security.sudo.enable = false;
}
