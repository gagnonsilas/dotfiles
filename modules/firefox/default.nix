{ ... }:
{

  programs.firefox = {
    enable = true;
    profiles = {
      silas = {
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };
}
