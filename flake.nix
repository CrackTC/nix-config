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
    nixpkgs-stable = { url = "github:nixos/nixpkgs/nixos-23.11"; flake = false; };
    nur = { url = "github:nix-community/NUR"; flake = false; };
    myRepo = { url = "github:CrackTC/nur-packages"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix = { url = "github:Mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
    { nixpkgs
    , nixpkgs-stable
    , nur
    , myRepo
    , home-manager
    , sops-nix
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = true;
        config.cudnnSupport = true;
        config.permittedInsecurePackages = [
          "openssl-1.1.1w"
          "electron-22.3.27"
          "electron-25.9.0"
        ];
      };

      extraRepos = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        nur = import nur { inherit pkgs; nurpkgs = pkgs; };
        myRepo = myRepo.legacyPackages.${system};
      };

      info = {
        username = "chen";
        nickname = "CrackTC";
        email = "chenrke369@gmail.com";
      };
    in
    {
      nixosConfigurations = {
        cno = nixpkgs.lib.nixosSystem rec {
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
        };
      };
    };
}
