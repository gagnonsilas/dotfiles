{ pkgs, ... }:

{


  home.packages = with pkgs; [
    clang-tools
    lldb
    nixd
    glibc
    uclibc
    # matlab-language-server

    # Language servers
    vhdl-ls
    verible
    svls
    zls
    nixd
    # python311Packages.python-lsp-server
    nodePackages.bash-language-server
    # typst-lsp
    nixfmt-rfc-style
    tinymist
    typstyle
    # pkgs.symlinkJoin {
    #   name = "qc ";
    #   paths = [writeScriptBin "qc" ''
    #     (read a; qalc -t $a)
    #   '' libqalculate];
    #   buildInputs = [makeWrapper];
    #   postBuild = "wrapProgram $out/bin/qc --prefix PATH : $out/bin";
    # }
    libqalculate
    (writeScriptBin "qc" ''
      #!${pkgs.zsh}/bin/zsh
      read a 
      qalc -t $a
    '')

    # (writeTextFile {
    #   name = "qc";
    #   executable = true;
    #   destination = "/bin/}";
    #   text = ''
    #     read a 
    #     qalc -t $a
    #     '';
    #   checkPhase = ''
    #     ${stdenv.shell} -n $out/bin/${name}
    #   '';
    #   })
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
      language-server.matlab-lsp= { 
        command = "matlab-language-server"; 
        args = [
          "--stdio"
          "--matlabInstallPath /home/silas/WPI/classes/RBE/3001/matlab/install_dir/bin/matlab"
        ];
        # command = "mlang";
      };
      language-server.verilog-lsp= { 
        command = "svls"; 
      };
      language-server.tinymist = {
        config = {
          # exportPdf = "onDocumentHasTitle";
          formatterMode = "typstyle";
          # outputPath = "$root/out/$dir/$name";
        };
      };

      language-server.nixd = {
        command = "nixd";
      };

      language = [
        {
          name = "cpp";
          # indent = { tab-width = 4;  unit = "   "; };
        }
        {
          name = "matlab";
          indent = { 
            tab-width = 4; 
            unit = "    "; 
          };
          language-servers = ["matlab-lsp"];
        }
        {
          name = "nix";
          indent = { 
            tab-width = 4; 
            unit = " "; 
          };
          formatter = { command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";};
          language-servers = [ "nixd" ];
        }
        {
          name = "verilog";
        }
      ];
    };

    
    ignores = [
      ".direnv"
    ];

    settings = {
      # theme = "doom_acario_dark";
      theme = "ayu_dark";
      editor = {
        bufferline = "always";
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "error";
        };
        file-picker = {
          hidden = false;
          git-ignore = false;
        };
        indent-guides.render = true;
        auto-pairs = true;
        line-number = "relative";
        soft-wrap.enable = true;
        mouse = true;
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
          q = {
            # p = ":run-shell-command";
            # w = ":";
            b = ":echo %sh{git blame -L %{cursor_line},+1 %{buffer_name}}";
            f = ":format";
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

