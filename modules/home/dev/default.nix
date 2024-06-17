{ config, lib, ... }: {
  imports = [
    ./asm.nix
    ./board.nix
    ./c.nix
    ./ctf
    ./dotnet
    ./fhs.nix
    ./fzf.nix
    ./go.nix
    ./godot.nix
    ./haskell.nix
    ./ideavimrc.nix
    ./java
    ./jetbrains.nix
    ./js
    ./lsp.nix
    ./lua.nix
    ./man.nix
    ./net.nix
    ./nix.nix
    ./php.nix
    ./podman.nix
    ./protobuf.nix
    ./python
    ./scheme.nix
    ./tealdeer.nix
    ./verilog.nix
  ];

  options.dev = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "User does development";
    };
  };

  config = lib.mkIf config.dev.enable {
    asm.enable = true;
    board.enable = true;
    c.enable = true;
    ctf.enable = true;
    dotnet.enable = true;
    fhs.enable = true;
    fzf.enable = true;
    go.enable = true;
    godot.enable = true;
    haskell.enable = true;
    ideavimrc.enable = true;
    java.enable = true;
    js.enable = true;
    lsp.enable = true;
    lua.enable = true;
    man.enable = true;
    net.enable = true;
    nix.enable = true;
    php.enable = true;
    podman.enable = true;
    protobuf.enable = true;
    python.enable = true;
    scheme.enable = true;
    tealdeer.enable = true;
    verilog.enable = true;
  };
}
