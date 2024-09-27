{ pkgs, ... }:

{

  home.packages = with pkgs; [
    clang-tools
    lldb
    nixd
    glibc
    uclibc

    # Language servers
    vhdl-ls
    verible
    svls
    zls
    nil
    python311Packages.python-lsp-server
    nodePackages.bash-language-server
    # typst-lsp
    tinymist
    typstyle
  ];

  programs.helix = {
    enable = true;

    languages = {
      language-server.cpp-lsp= { 
        command = "clangd"; 
        args = [
          "--compile-commands-dir=compile_commands_directory"
        ];
      };
      language-server.verilog-lsp= { 
        command = "svls"; 
      };
      language-server.tinymist = {
        config = {
          exportPdf = "onDocumentHasTitle";
          formatterMode = "typstyle";
          outputPath = "$root/out/$dir/$name";
        };
      };

      language = [
        {
          name = "cpp";
          indent = { 
            tab-width = 4; 
            unit = " "; 
          };
        }
        {
          name = "verilog";
        }
      ];
    };

    

    settings = {
      theme = "doom_acario_dark";
      editor = {
        bufferline = "always";
        file-picker = {
          hidden = false;
          git-ignore = false;
        };
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
          space = {
            f = "file_picker_in_current_directory";
            F = "file_picker";
          };

        };
        select = {
          n = "extend_line_down";
          e = "extend_line_up";
          i = "extend_char_right";
          h = "extend_char_left";
          N = "extend_search_next";
          E = "extend_search_prev";
        }; 
      };

    };
  };
}

