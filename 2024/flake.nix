{
  description = "HeitorAugustoLN's Advent of code 2024 solutions";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default =
            let
              ghc = pkgs.haskellPackages.ghcWithPackages (
                p: with p; [
                  regex-base
                  regex-pcre-builtin
                ]
              );
            in
            pkgs.mkShell {
              strictDeps = true;

              nativeBuildInputs = [
                ghc
              ];
            };
        };
    };
}
