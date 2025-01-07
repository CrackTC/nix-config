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
    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
      flake = false;
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
      flake = false;
    };
    nixpkgs-mine = {
      url = "github:CrackTC/nixpkgs";
      flake = false;
    };

    myRepo = {
      url = "github:CrackTC/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
      flake = false;
    };
    nur = {
      url = "github:nix-community/NUR";
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

    hyprland = {
      url = "github:hyprwm/hyprland/b9f110ef8726fcba2b4ee69856027731e73003a5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty/main";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-master,
      nixpkgs-stable,
      nixpkgs-mine,
      hyprland,
      ghostty,
      nil,
      nur,
      myRepo,
      home-manager,
      sops-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      utilities = import ./utils { inherit lib; };

      getSubDirs =
        path:
        builtins.readDir path |> lib.attrsets.filterAttrs (_: v: v == "directory") |> builtins.attrNames;

      hosts = getSubDirs ./config/hosts;
      homes =
        getSubDirs ./config/homes
        |> map (name: {
          inherit name;
          value = import (./config/homes/. + "/${name}");
        })
        |> builtins.listToAttrs;
    in
    {
      nixosConfigurations =
        hosts
        |> map (
          host-name:
          let
            host-info = import ./config/hosts/${host-name}/flake-info.nix;

            options = utilities.nixpkgsOptions { inherit (host-info) system cpu; };

            pkgs = import nixpkgs (
              options
              // {
                overlays = [ nur.overlays.default ];
              }
            );

            extraRepos = {
              # pkgs-native = import nixpkgs (lib.utils.nixpkgsOptions host-info.system host-info.cpu true);
              pkgs-master = import nixpkgs-master options;
              pkgs-stable = import nixpkgs-stable options;
              pkgs-mine = import nixpkgs-mine options;
              myRepo = import myRepo { inherit pkgs; };

              hyprland = hyprland.packages.${host-info.system};
              ghostty = ghostty.packages.${host-info.system};
              nil = nil.packages.${host-info.system};
            };

            specialArgs = {
              inherit extraRepos;
              inherit utilities;
            };
          in
          {
            name = host-name;
            value = nixpkgs.lib.nixosSystem {
              inherit specialArgs;
              modules = [
                sops-nix.nixosModules.sops
                home-manager.nixosModules.home-manager

                ./modules/host
                ./modules/home

                {
                  nixpkgs.pkgs = pkgs;
                  sorac = {
                    host = host-info // {
                      name = host-name;
                    };
                    inherit homes;
                  };
                }

                ./config/hosts/${host-name}
              ];
            };
          }
        )
        |> builtins.listToAttrs;
    };
}
