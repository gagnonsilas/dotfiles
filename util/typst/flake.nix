{
  description = "Homework environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
    # typst-src.url = "github:typst/typst";
  };

  outputs =
    inputs@{ nixpkgs, systems, ... }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = eachSystem (
        system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };

          typst-zellij-layout = (
            pkgs.writeTextFile {
              name = "typst-layout.kdl.template";
              text = ''
                layout {
                    tab name="main" hide_floating_panes=true {
                        pane edit="''${TYPST_FILE}" {
                            size "80%"
                        }
                        pane split_direction="vertical" {
                            pane command="typst" {
                                args "watch" "''${TYPST_FILE}" "''${OUTPUT_FILE}"
                            }
                        }
                        floating_panes {
                            pane command="zathura" {
                                args "''${OUTPUT_FILE}"
                            }
                        }
                    }
                }
              '';
            }
          );
        in
        {
          default = pkgs.mkShell {
            name = "typst";
            packages = with pkgs; [
              typst
              typstyle
              tinymist
              envsubst
              zellij
              jq
              (writeShellScriptBin "dev" ''
                export TYPST_FILE=''$1 
                export OUTPUT_FILE=''$2 h
                touch ''$TYPST_FILE
                mkdir -p out
                typst compile ''$TYPST_FILE ''$OUTPUT_FILE
                envsubst < ${typst-zellij-layout} > layout.kdl
                sleep 1 && rm layout.kdl &
                zellij --layout layout.kdl
              '')
            ];

            shellHook = ''
              unset SOURCE_DATE_EPOCH
            '';
          };
        }
      );
    };
}
