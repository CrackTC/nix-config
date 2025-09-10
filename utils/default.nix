{ lib, ... }:
{
  nixpkgsOptions =
    {
      system,
      cpu,
      native ? false,
    }:
    {
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-11.5.0"
          "qtwebengine-5.15.19"
        ];
        android_sdk.accept_license = true;
      };
    }
    // (
      if !native then
        { inherit system; }
      else
        {
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
        }
    );

  foreachAttr = lib.flip builtins.mapAttrs;

  anythingMerged =
    let
      anythingMerged_ =
        with lib;
        with types;
        mkOptionType {
          name = "anythingMerged";
          description = "anything but with lists merged";
          descriptionClass = "noun";
          check = value: true;
          merge =
            loc: defs:
            let
              getType =
                value: if isAttrs value && isStringLike value then "stringCoercibleSet" else builtins.typeOf value;

              # Returns the common type of all definitions, throws an error if they
              # don't have the same type
              commonType = foldl' (
                type: def:
                if getType def.value == type then
                  type
                else
                  throw "The option `${showOption loc}' has conflicting option types in ${showFiles (getFiles defs)}"
              ) (getType (head defs).value) defs;

              mergeFunction =
                {
                  # Recursively merge attribute sets
                  set = (attrsOf anythingMerged_).merge;
                  # Merge lists
                  list = (listOf anythingMerged_).merge;
                  # This is the type of packages, only accept a single definition
                  stringCoercibleSet = mergeOneOption;
                  string = lines.merge;
                  lambda =
                    loc: defs: arg:
                    anythingMerged_.merge (loc ++ [ "<function body>" ]) (
                      map (def: {
                        inherit (def) file;
                        value = def.value arg;
                      }) defs
                    );
                  # Otherwise fall back to only allowing all equal definitions
                }
                .${commonType} or mergeEqualOption;
            in
            mergeFunction loc defs;
        };
    in
    anythingMerged_;

  osConfigAttrs = [
    "appstream"
    "boot"
    "console"
    "containers"
    "documentation"
    "ec2"
    "environment"
    "fileSystems"
    "fonts"
    "gtk"
    "hardware"
    "home-manager"
    "i18n"
    "ids"
    "krb5"
    "lib"
    "location"
    "meta"
    "nesting"
    "networking"
    "nix"
    "nixops"
    "nixpkgs"
    "oci"
    "openstack"
    "passthru"
    "power"
    "powerManagement"
    "programs"
    "qt"
    "qt5"
    "security"
    "services"
    "sops"
    "specialisation"
    "stubby"
    "system"
    "systemd"
    "time"
    "users"
    "virtualisation"
    "xdg"
    "zramSwap"
  ];
}
