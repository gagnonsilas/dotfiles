{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # libclang
    clang-tools
    lldb
    nil 
    glibc
    uclibc
  ];


  
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16_default";
      editor = {
        bufferline = "always";
        file-picker.hidden = false;
        indent-guides.render = true;
        auto-pairs = true;
        line-number = "relative";
        mouse = false;
        insert-final-newline = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline.center = ["version-control" "register"];
      };
      keys = {
        normal = {
          g = { a = "code_action"; };
          n = "move_line_down";
          e = "move_line_up";
          i = "move_char_right";
          h = "move_char_left";
          l = "insert_mode";
          L = "insert_at_line_start";
          N = "search_next";
          E = "search_prev";
          I = "move_next_word_end";
          H = "move_prev_word_start";
          C-w = {
            h = "jump_view_left";
            n = "jump_view_down";
            e = "jump_view_up";
            i = "jump_view_right";
            H = "swap_view_left";
            N = "swap_view_down";
            E = "swap_view_up";
            I = "swap_view_right";
          };
        };
        select = {
          n = "extend_line_down";
          e = "extend_line_up";
          i = "extend_char_right";
          h = "extend_char_left";
        }; 
      };
    };
  };
}

