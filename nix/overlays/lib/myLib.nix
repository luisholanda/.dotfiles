self: super:
with builtins;
with super.lib; {
  myLib = {
    # Flattens an attribute set, that is
    #
    # flattenAttrs {
    #   a = {
    #     b = {
    #       c = {
    #         d = 1;
    #       };
    #       e = true;
    #     };
    #     f = "bla";
    #   };
    # }
    #
    # becomes
    #
    # {
    #   "a.b.c.d" = 1;
    #   "a.b.e" = true;
    #   "a.f" = "bla";
    # }
    flattenAttrs = let
      expandAttr = path: value: {
        inherit value;
        name = concatStringsSep "." path;
        __expanded__ = true;
      };
      isExpanded = v: isAttrs v -> v ? "__expanded__";
    in flip pipe [ (mapAttrsRecursive expandAttr) (collect isExpanded) listToAttrs ];
  };
}
