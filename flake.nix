{
  description = "Sorac no NixOS Flake";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://cracktc.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cracktc.cachix.org-1:2hSlXvkhNchqB0wo+nz13bWdJo9/nxrAi/masgZCm2I="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master = { url = "github:NixOS/nixpkgs/master"; flake = false; };
    nixpkgs-stable = { url = "github:NixOS/nixpkgs/nixos-24.11"; flake = false; };
    nixpkgs-mine = { url = "github:CrackTC/nixpkgs"; flake = false; };
    hyprland.url = "github:hyprwm/hyprland/e75e2cdac79417ffdbbbe903f72668953483a4e7";
    nur = { url = "github:nix-community/NUR"; flake = false; };
    myRepo = { url = "github:CrackTC/nur-packages"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    { nixpkgs
    , nixpkgs-master
    , nixpkgs-stable
    , nixpkgs-mine
    , hyprland
    , nur
    , myRepo
    , home-manager
    , sops-nix
    , ...
    }:
    let
      hosts = [ "cno" ];
      utilities = import ./utils;
    in
    {
      nixosConfigurations = builtins.listToAttrs (map
        (host-name: {
          name = host-name;
          value = nixpkgs.lib.nixosSystem
            (
              let
                host-info = import ./config/hosts/${host-name}/flake-info.nix;
                option = utilities.nixpkgsOptions host-info.system host-info.cpu false;

                pkgs = import nixpkgs option;
                extraRepos = {
                  # pkgs-native = import nixpkgs (lib.utils.nixpkgsOptions host-info.system host-info.cpu true);
                  pkgs-master = import nixpkgs-master option;
                  pkgs-stable = import nixpkgs-stable option;
                  pkgs-mine = import nixpkgs-mine option;

                  hyprland = hyprland.packages.${host-info.system};
                  nur = import nur { inherit pkgs; nurpkgs = pkgs; };
                  myRepo = myRepo.legacyPackages.${host-info.system};
                };
                specialArgs = { inherit pkgs extraRepos; inherit utilities; };
              in
              {
                inherit specialArgs;
                modules = [
                  sops-nix.nixosModules.sops
                  home-manager.nixosModules.home-manager

                  {
                    sorac = {
                      host = host-info // { name = host-name; };
                      homes = import ./config/homes;
                    };
                  }

                  ./config/hosts/${host-name}
                  ./modules/host
                  ./modules/home
                ];
              }
            );
        })
        hosts);
    };
}
