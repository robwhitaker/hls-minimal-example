{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        haskellPackages = pkgs.haskell.packages.ghc922.override {
          overrides = final: prev: {
            hls-minimal-example = final.callCabal2nix "hls-minimal-example" self {};
          };
        };
        projectGhc = haskellPackages.ghcWithHoogle (_:
          haskellPackages.hls-minimal-example.getBuildInputs.haskellBuildInputs
        );
      in
      rec {
        packages.hls-minimal-example = haskellPackages.hls-minimal-example;
        defaultPackage = packages.hls-minimal-example;

        devShell = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            projectGhc
            cabal2nix
            cabal-install
            haskell-language-server
          ];
        };
      }
    );
}
