{
  description = "Sorac no NixOS Flake";

  nixConfig = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cracktc.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cracktc.cachix.org-1:2hSlXvkhNchqB0wo+nz13bWdJo9/nxrAi/masgZCm2I="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master = { url = "github:NixOS/nixpkgs/master"; flake = false; };
    nixpkgs-stable = { url = "github:nixos/nixpkgs/nixos-23.11"; flake = false; };
    nur = { url = "github:nix-community/NUR"; flake = false; };
    myRepo = { url = "github:CrackTC/nur-packages"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix = { url = "github:Mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
    { nixpkgs
    , nixpkgs-master
    , nixpkgs-stable
    , nur
    , myRepo
    , home-manager
    , sops-nix
    , ...
    }:
    let
      info = {
        username = "chen";
        nickname = "CrackTC";
        email = "chenrke369@gmail.com";
      };

      opt = system: native: {
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "openssl-1.1.1w"
          "electron-22.3.27"
          "electron-25.9.0"
        ];
      } // (if native then {
        localSystem = { inherit system; gcc.arch = "alderlake"; gcc.tune = "alderlake"; };

        overlays = [
          (self: super: {
            opencolorio = super.opencolorio.overrideAttrs { doCheck = false; };

            haskellPackages = super.haskellPackages.override {
              overrides = hself: hsuper: {
                crypton = super.haskell.lib.dontCheck hsuper.crypton;
                crypton-x509-validation = super.haskell.lib.dontCheck hsuper.crypton-x509-validation;
                tls_1_9_0 = super.haskell.lib.dontCheck hsuper.tls_1_9_0;
                tls = super.haskell.lib.dontCheck hsuper.tls;
                cryptonite = super.haskell.lib.overrideCabal hsuper.cryptonite (oa: {
                  doCheck = false;
                });
                x509-validation = super.haskell.lib.overrideCabal hsuper.x509-validation (oa: {
                  doCheck = false;
                });
              };
            };

            pythonPackagesExtensions =
              let
                dontCheckPy = (names: pysuper: super.lib.foldr
                  (name: ps: ps // {
                    "${name}" = pysuper.${name}.overridePythonAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                    });
                  })
                  { }
                  names
                );
              in
              super.pythonPackagesExtensions ++ [
                (pyself: dontCheckPy [
                  "numpy"
                  "pandas"
                ])
              ];
          })
        ];
      } else { inherit system; });
    in
    {
      nixosConfigurations = {
        cno = nixpkgs.lib.nixosSystem (
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs (opt system false);
            extraRepos = {
              # pkgs-native = import nixpkgs (opt system true);
              pkgs-master = import nixpkgs-master (opt system false);
              pkgs-stable = import nixpkgs-stable (opt system false);
              nur = import nur { inherit pkgs; nurpkgs = pkgs; };
              myRepo = myRepo.legacyPackages.${system};
            };
          in
          rec {
            specialArgs = { inherit pkgs extraRepos info; };
            modules = [
              ./modules
              ./host/cno
              sops-nix.nixosModules.sops
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${info.username} = import ./home/${info.username};
                  extraSpecialArgs = specialArgs;
                };
              }
            ];
          }
        );
      };
    };
}
