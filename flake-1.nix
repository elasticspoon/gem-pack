{
  description = "Pablo's Cooking Website";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        ruby = pkgs.ruby_3_2;

        env = pkgs.bundlerEnv {
          name = "solargraph-standrdrb-env";
          inherit ruby;
          gemfile = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset = ./gemset.nix;
        };
      in
      with pkgs; {
        devShells.default = mkShell {
          buildInputs = [ env ];
        };

        packages.default = stdenv.mkDerivation {
          name = "Cooking";
          src = self;
          buildInputs = [ env pkgs.ruby_3_2 ];

          buildPhase = ''
            bundle install
          '';

          installPhase = ''
            echo "Solargraph: ${env.gems.solargraph}"
            echo "Standard: ${env.gems.standard}"
            mkdir -p $out
            echo "Installing gems to $out"
          '';
        };
      }
    );
}
