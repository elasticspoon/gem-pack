# with (import <nixpkgs> { }); let
#   env = bundlerEnv {
#     name = "test-bundler-env";
#     ruby = pkgs.ruby_3_2;
#     gemfile = ./Gemfile;
#     lockfile = ./Gemfile.lock;
#     gemset = ./gemset.nix;
#   };
# in
# stdenv.mkDerivation {
#   name = "test";
#   buildInputs = [ env pkgs.ruby_3_2 ];
#
#   buildPhase = ''
#     bundle install
#   '';
#
#   installPhase = ''
#     mkdir -p $out
#   '';
# }
with import <nixpkgs> { }; let
  gems = bundlerEnv {
    name = "gems-for-some-project";
    gemdir = ./.;
  };
in
# mkShell { packages = [ gems gems.wrappedRuby ]; }
stdenv.mkDerivation
{
  packages = [ pkgs.ruby ];
  name = "test";
}
