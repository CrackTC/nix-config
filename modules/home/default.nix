{ pkgs, config, lib, extraRepos, utilities, ... }:
let
  anythingMerged = with lib; with types; mkOptionType {
    name = "anythingMerged";
    description = "anything but with lists merged";
    descriptionClass = "noun";
    check = value: true;
    merge = loc: defs:
      let
        getType = value:
          if isAttrs value && isStringLike value
          then "stringCoercibleSet"
          else builtins.typeOf value;

        # Returns the common type of all definitions, throws an error if they
        # don't have the same type
        commonType = foldl'
          (type: def:
            if getType def.value == type
            then type
            else throw "The option `${showOption loc}' has conflicting option types in ${showFiles (getFiles defs)}"
          )
          (getType (head defs).value)
          defs;

        mergeFunction = {
          # Recursively merge attribute sets
          set = (attrsOf anythingMerged).merge;
          # Merge lists
          list = (listOf anythingMerged).merge;
          # This is the type of packages, only accept a single definition
          stringCoercibleSet = mergeOneOption;
          string = lines.merge;
          lambda = loc: defs: arg: anythingMerged.merge
            (loc ++ [ "<function body>" ])
            (map
              (def: {
                inherit (def) file;
                value = def.value arg;
              })
              defs);
          # Otherwise fall back to only allowing all equal definitions
        }.${commonType} or mergeEqualOption;
      in
      mergeFunction loc defs;
  };

  homeConfiguration = lib.types.submodule {
    imports = [
      ./dev
      ./fcitx5
      ./game
      ./gui
      ./rofi
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
      mergeOSAttr = attr: lib.mkMerge (builtins.map (home: home.osConfig.${attr} or { }) homeConfigs);
    in
    lib.mkMerge [
      # osConfig <- infinite recursion
      # this works but ugly
      {
        boot = mergeOSAttr "boot";
        environment = mergeOSAttr "environment";
        hardware = mergeOSAttr "hardware";
        networking = mergeOSAttr "networking";
        programs = mergeOSAttr "programs";
        security = mergeOSAttr "security";
        services = mergeOSAttr "services";
        specialisation = mergeOSAttr "specialisation";
        system = mergeOSAttr "system";
        systemd = mergeOSAttr "systemd";
        users = mergeOSAttr "users";
        virtualisation = mergeOSAttr "virtualisation";
        xdg = mergeOSAttr "xdg";
      }
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users = utilities.foreachAttr config.sorac.homes
            (username: home: lib.mkMerge [
              {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                  stateVersion = "23.05";
                };
                programs.home-manager.enable = true;
              }
              config.sorac.homes.${username}.hmConfig
            ]);
        };
      }
    ];
}
