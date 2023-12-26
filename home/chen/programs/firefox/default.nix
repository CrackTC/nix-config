{ extraRepos, ... }:
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
        extensions = with extraRepos.nur.repos.rycee.firefox-addons; [
          bitwarden
          gloc
          kristofferhagen-nord-theme
          tabliss
          tampermonkey
          vimium
        ];
      };
    };
  };
}
