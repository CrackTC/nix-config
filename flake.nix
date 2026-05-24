{
  description = "Sorac no NixOS Flake";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://cracktc.cachix.org"
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
      "https://ghostty.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cracktc.cachix.org-1:2hSlXvkhNchqB0wo+nz13bWdJo9/nxrAi/masgZCm2I="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    myRepo.url = "github:CrackTC/nur-packages";
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
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      nixpkgs,
      nur,
      sops-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      utilities = import ./utils { inherit lib; };

      getSubDirs =
        path:
        path |> builtins.readDir |> lib.attrsets.filterAttrs (_: v: v == "directory") |> builtins.attrNames;
    in
    {
      nixosConfigurations =
        ./config/hosts
        |> getSubDirs
        |> map (
          host-name:
          let
            host-info = import ./config/hosts/${host-name}/flake-info.nix;
            options = utilities.nixpkgsOptions { inherit (host-info) system cpu; };
            pkgs = (options // { overlays = [ nur.overlays.default ]; }) |> import nixpkgs;
            specialArgs = {
              inherit inputs utilities;
              inherit (host-info) system;
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
                    host = {
                      name = host-name;
                      inherit (host-info) cpu;
                    };
                    homes =
                      getSubDirs ./config/homes
                      |> map (name: {
                        inherit name;
                        value = import (./config/homes/. + "/${name}");
                      })
                      |> builtins.listToAttrs;
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
