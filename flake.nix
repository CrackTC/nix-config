{
  description = "Sorac no NixOS Flake";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/NUR";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    };
  };

  outputs = { nixpkgs, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "openssl-1.1.1w"
          "electron-22.3.27"
          "electron-25.9.0"
        ];
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      nur = import inputs.nur {
        nurpkgs = pkgs;
        pkgs = pkgs;
      };
      myRepo = import inputs.myRepo {
        pkgs = pkgs;
      };
      extraRepos = {
        inherit pkgs-stable;
        inherit nur;
        inherit myRepo;
        inherit (inputs) hyprland-contrib;
      };

      info = {
        username = "chen";
        nickname = "CrackTC";
        email = "chenrke369@gmail.com";
      };
    in
    {
      nixosConfigurations = {
        cno = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs extraRepos info;
          };
          modules = [
            ./modules
            ./host/cno
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${info.username} = import ./home;
              home-manager.extraSpecialArgs = { inherit pkgs extraRepos info; };
            }
          ];
        };
      };
    };
}
