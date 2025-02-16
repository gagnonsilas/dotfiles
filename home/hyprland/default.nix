{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slurp
    grim
    swww
    waybar
    foot
    wl-clipboard
    wtype
    mako

    nerd-fonts.dejavu-sans-mono
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;
    enableNvidiaPatches = true;

    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F2, exec, firefox"
          "$mod, Return, exec, foot"
          "$mod, code:40, exec, wofi --show drun"
          "$mod Shift, Q, killactive,"
          "$mod, space, togglefloating,"
          "$mod, F, fullscreen,"
          "$mod, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy -t image/png"
          "Print, exec, grim - | wl-copy -t image/png"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      monitor = 
        [ 
          ",preferred,auto,auto"
          "eDP-1,preferred,auto,1"
        ];
      animations.enabled = false;
      input = {
        kb_layout = "us,us";
        kb_variant = "colemak,";
        kb_options = "grp:alt_shift_toggle,caps:ctrl_modifier";
      };
      general = {
        gaps_in = 7;
        gaps_out = 2;
        border_size = 2;
      };
    };
  };
}
