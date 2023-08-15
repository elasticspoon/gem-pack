{ bundlerApp }:
bundlerApp {
  pname = "solargraph";
  gemdir = ./.;
  exes = [ "solargraph" ];
}
