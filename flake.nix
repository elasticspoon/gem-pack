{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      gems = pkgs.bundlerEnv {
        name = "gemset";
        gemdir = ./.;
      };
      app = pkgs.bundlerApp {
        pname = "solargraph-standardrb";
        gemdir = ./.;
        exes = [ "solargraph" ];
      };
    in
    {
      devShell = with pkgs;
        mkShell {
          buildInputs = [
            gems
            gems.wrappedRuby
          ];
        };
      defaultApp = app;
    });
}
