{
  nixpkgsOptions = system: cpu: native: { config.allowUnfree = true; } //
    (if !native then { inherit system; } else {
      localSystem = {
        inherit system;
        gcc = {
          arch = cpu;
          tune = cpu;
        };
      };

      # Workarounds might be outdated, test if they are still needed
      # overlays = [
      #   (self: super: {
      #     opencolorio = super.opencolorio.overrideAttrs { doCheck = false; };
      #
      #     haskellPackages = super.haskellPackages.override {
      #       overrides = hself: hsuper: {
      #         crypton = super.haskell.lib.dontCheck hsuper.crypton;
      #         crypton-x509-validation = super.haskell.lib.dontCheck hsuper.crypton-x509-validation;
      #         tls_1_9_0 = super.haskell.lib.dontCheck hsuper.tls_1_9_0;
      #         tls = super.haskell.lib.dontCheck hsuper.tls;
      #         cryptonite = super.haskell.lib.overrideCabal hsuper.cryptonite (oa: { doCheck = false; });
      #         x509-validation = super.haskell.lib.overrideCabal hsuper.x509-validation (oa: { doCheck = false; });
      #       };
      #     };
      #
      #     pythonPackagesExtensions =
      #       let
      #         dontCheckPy = names: _: pysuper: super.lib.foldr
      #           (name: rhs: rhs // {
      #             "${name}" = pysuper.${name}.overridePythonAttrs (oldAttrs: {
      #               doCheck = false;
      #               doInstallCheck = false;
      #               dontCheck = true;
      #             });
      #           })
      #           { }
      #           names;
      #       in
      #       super.pythonPackagesExtensions ++ [ (dontCheckPy [ "numpy" "pandas" ]) ];
      #   })
      # ];
    });

  foreachAttr = set: f: builtins.mapAttrs f set;

  anyAttr = set: pred: builtins.any (name: pred name set.${name}) (builtins.attrNames set);

  powerfulUsers = homes: builtins.filter (username: homes.${username}.powerful) (builtins.attrNames homes);
}
