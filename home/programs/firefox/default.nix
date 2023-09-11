nur:
let
  profileName = "sorac";
in
{
  imports = [
    (import ./settings profileName)
  ];

  home.file.".mozilla/firefox/${profileName}/chrome" = {
    source = ./chrome;
    recursive = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      ${profileName} = {
        extensions = with nur.repos.rycee.firefox-addons; [
          bitwarden
          vimium
          kristofferhagen-nord-theme
        ];
      };
    };
  };
}
