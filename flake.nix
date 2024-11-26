{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { nixpkgs, devshell, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };

      in {
        devShell = pkgs.devshell.mkShell {
          motd = "\n  Welcome to the {2}sg_personal_week{reset} dev shell. Run {1}menu{reset} for commands.\n";
          packages = with pkgs; [
            typst  typst-lsp
          ];
          commands = [
            {
              name = "watch";
              command = "typst watch src/main.typ ./out.pdf";
              help = "Run typst in watch mode on a file";
            }
          ];
        };
      });
}
