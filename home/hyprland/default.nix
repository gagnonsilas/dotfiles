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

    settings = {
      "$mod" = "SUPER";

      env = [
        "HYPRCURSOR_THEME,phinger-cursors-dark"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR,phinger-cursors-dark"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      bindm = [
        "$mod , mouse:272, movewindow"
        "$mod , mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, F2, exec, firefox"
          "$mod, Return, exec, foot"
          "$mod, code:40, exec, rofi -show drun -show-icons"
          "$mod Shift, Q, killactive,"
          "$mod, space, togglefloating,"
          "$mod, F, fullscreen,"
          "$mod, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy -t image/png"
          # "Print, exec, grim - | wl-copy -t image/png"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      monitor = [
        ",preferred,auto,auto"
        "eDP-1,preferred,auto,1"
      ];

      animations.enabled = false;

      input = {
        kb_layout = "us,us";
        kb_variant = "colemak,";
        kb_options = "grp:alt_shift_toggle,caps:ctrl_modifier";
        touchpad.natural_scroll = true;
      };
      general = {
        gaps_in = 5;
        gaps_out = 2;
        border_size = 2;
      };

      gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = true;
          # workspace_swipe_distance = 100;
          workspace_swipe_cancel_ratio = 0.5;
          # workspace_swipe_numbered = true;
          workspace_swipe_create_new = false;
      };

      misc = {
          disable_hyprland_logo = true;
      };

      exec-once = [
        "nm-applet -sm-disable"
        "swww init"
        "waybar"
      ];
    };
  };
}
