# Just run 'nix develop' you need to have flake enabled. 
{
  description = "bbb-devenv flake";

  inputs = {
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/*.tar.gz";

    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";

    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  
  outputs = { self, flake-compat, flake-schemas, nixpkgs }:
    let
      # Helpers for producing system-specific outputs
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      # Schemas tell Nix about the structure of your flake's outputs
      schemas = flake-schemas.schemas;

      # Development environments
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          # Pinned packages available in the environment
          packages = with pkgs; [
            # base
            curl
            git
            jq
            wget
            nixpkgs-fmt
            # languages
            ruby
            jruby # interpreter for java if when used  
            
          ];

          # A hook run every time you enter the environment
          shellHook = ''
            no
          '';
        };
      });
    };
}
