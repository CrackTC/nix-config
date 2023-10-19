{pkgs, ...} : {
    home.packages = with pkgs; [
      dotnet-sdk_7
      csharp-ls
    ];
}
