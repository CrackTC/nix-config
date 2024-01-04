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
    nixpkgs-stable = { url = "github:NixOS/nixpkgs/nixos-23.11"; flake = false; };
    nur = { url = "github:nix-community/NUR"; flake = false; };
    myRepo = {
      url = "github:CrackTC/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
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

      opt = system: cpu: native: {
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ "electron-25.9.0" ];
      } //
      (if !native then { inherit system; } else {
        localSystem = { inherit system; gcc.arch = cpu; gcc.tune = cpu; };
        overlays = [
          (self: super: {
            opencolorio = super.opencolorio.overrideAttrs { doCheck = false; };

            haskellPackages = super.haskellPackages.override {
              overrides = hself: hsuper: {
                crypton = super.haskell.lib.dontCheck hsuper.crypton;
                crypton-x509-validation = super.haskell.lib.dontCheck hsuper.crypton-x509-validation;
                tls_1_9_0 = super.haskell.lib.dontCheck hsuper.tls_1_9_0;
                tls = super.haskell.lib.dontCheck hsuper.tls;
                cryptonite = super.haskell.lib.overrideCabal hsuper.cryptonite (oa: { doCheck = false; });
                x509-validation = super.haskell.lib.overrideCabal hsuper.x509-validation (oa: { doCheck = false; });
              };
            };

            pythonPackagesExtensions =
              let
                dontCheckPy = (names: _: pysuper: super.lib.foldr
                  (name: rhs: rhs // {
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
              super.pythonPackagesExtensions ++ [ (dontCheckPy [ "numpy" "pandas" ]) ];
          })
        ];
      });
    in
    {
      nixosConfigurations = {
        cno = nixpkgs.lib.nixosSystem (
          let
            host = { name = "cno"; system = "x86_64-linux"; cpu = "alderlake"; };
            option = opt host.system host.cpu false;

            pkgs = import nixpkgs option;
            extraRepos = {
              # pkgs-native = import nixpkgs (opt system true);
              pkgs-master = import nixpkgs-master option;
              pkgs-stable = import nixpkgs-stable option;

              nur = import nur { inherit pkgs; nurpkgs = pkgs; };
              myRepo = myRepo.legacyPackages.${host.system};
            };
          in
          rec {
            specialArgs = { inherit pkgs extraRepos info host; };
            modules = [
              ./modules
              ./host/${host.name}
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
