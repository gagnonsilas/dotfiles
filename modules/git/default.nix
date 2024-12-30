{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      keybinding = {
        universal = {
          prevItem-alt = "e";
          nextItem-alt = "n";
          prevBlock-alt = "h";
          nextBlock-alt = "i";
                
          scrollUpMain-alt1 =  "E";
          scrollDownMain-alt1 =  "N";
          scrollLeft = "H";
          scrollRight = "I";
          edit = "l";
        };

        files.ignoreFile = "y";
        branches.viewGitFlowOptions = "y";
        commits.startInteractiveRebase = "y";
        submodules.init = "y";
      };


    };
  };
}
