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
      url = "github:hyprwm/hyprland";
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
                overlays = [
                  nur.overlays.default
                  (final: prev: {
                    linuxPackages_latest = prev.linuxPackages_latest.extend (
                      lfinal: lprev: {
                        kvmfr = prev.linuxPackages_latest.kvmfr.overrideAttrs (old: {
                          patches = [
                            (prev.fetchpatch {
                              url = "https://github.com/gnif/LookingGlass/commit/4251a5c5fe7723c5dc068839debd76a5148953b2.diff";
                              sha256 = "sha256-CswVgctC4G58cNFHrAh3sHsgOlB2ENJ/snyWQAHO6Ks=";
                              stripLen = 1;
                              includes = [
                                "dkms.conf"
                                "kvmfr.c"
                              ];
                            })
                          ];
                        });
                      }
                    );
                    looking-glass-client = prev.looking-glass-client.overrideAttrs (old: {
                      version = "master";
                      src = prev.fetchFromGitHub {
                        owner = "gnif";
                        repo = "LookingGlass";
                        sha256 = "sha256-DBmCJRlB7KzbWXZqKA0X4VTpe+DhhYG5uoxsblPXVzg=";
                        rev = "e25492a3a36f7e1fde6e3c3014620525a712a64a";
                        fetchSubmodules = true;
                      };
                      patches = [ ./modules/home/virt/nanosvg-unvendor.diff ];
                    });

                    # https://github.com/NixOS/nixpkgs/issues/392278
                    auto-cpufreq = prev.auto-cpufreq.overrideAttrs (oldAttrs: {
                      postPatch =
                        oldAttrs.postPatch
                        + ''

                          substituteInPlace pyproject.toml \
                          --replace-fail 'psutil = "^6.0.0"' 'psutil = ">=6.0.0,<8.0.0"'
                        '';
                    });

                    # pr 392319
                    zed-editor = prev.zed-editor.overrideAttrs (oldAttrs: {
                      postPatch =
                        # Dynamically link WebRTC instead of static
                        ''
                          substituteInPlace $cargoDepsCopy/webrtc-sys-*/build.rs \
                            --replace-fail "cargo:rustc-link-lib=static=webrtc" "cargo:rustc-link-lib=dylib=webrtc"
                        ''
                        # nixpkgs ships cargo-about 0.7, which is a seamless upgrade from 0.6
                        + ''
                          substituteInPlace script/generate-licenses \
                            --replace-fail 'CARGO_ABOUT_VERSION="0.6"' 'CARGO_ABOUT_VERSION="0.7"'
                        '';
                    });
                  })
                ];
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
