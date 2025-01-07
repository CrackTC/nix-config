{
  pkgs,
  config,
  lib,
  extraRepos,
  utilities,
  ...
}:
let
  inherit (utilities) anythingMerged;
  homeConfiguration = lib.types.submodule {
    imports = [
      ./dev
      ./fcitx5
      ./game
      ./gui
      ./pinentry.nix
      ./programs
      ./theme
      ./tui
      ./user.nix
      ./virt
      ./wayland
      ./xdg
    ];

    options = {
      email = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Email address";
      };
      osConfig = lib.mkOption {
        type = lib.types.attrsOf anythingMerged;
        default = { };
        description = "OS configuration";
      };
      hostConfig = lib.mkOption {
        type = lib.types.attrsOf anythingMerged;
        default = { };
        description = "Host configuration";
      };
      hmConfig = lib.mkOption {
        type = lib.types.attrsOf anythingMerged;
        default = { };
        description = "Home manager configuration";
      };
      colemak = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Use colemak layout";
        };
      };
    };

    config = {
      _module.args = {
        inherit pkgs extraRepos;
        osConfig = config;
        hostConfig = config.sorac.host;
      };
    };
  };
in
{
  options = {
    sorac.homes = lib.mkOption {
      type = lib.types.attrsOf homeConfiguration;
      default = { };
      description = "Home configurations";
    };
  };
  config =
    let
      homeConfigs = builtins.attrValues config.sorac.homes;
      mergeOSAttr = attr: homeConfigs |> map (home: home.osConfig.${attr} or { }) |> lib.mkMerge;
    in
    lib.mkMerge [
      # osConfig <- infinite recursion
      # this works but ugly
      (
        utilities.osConfigAttrs
        |> map (attr: {
          name = attr;
          value = mergeOSAttr attr;
        })
        |> builtins.listToAttrs
      )
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users = utilities.foreachAttr config.sorac.homes (
            username: home:
            lib.mkMerge [
              {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                  stateVersion = "23.05";
                };
                programs.home-manager.enable = true;
              }
              config.sorac.homes.${username}.hmConfig
            ]
          );
        };
      }
    ];
}
