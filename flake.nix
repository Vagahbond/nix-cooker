{
  description = "Manage your rices !";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-unit.url = "github:nix-community/nix-unit";
  };

  outputs = {
    nix-unit,
    nixpkgs,
    ...
  }: let
    allSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = nixpkgs {inherit system;};
        });
  in {
    lib = import ./lib;

    nixosModules.default = import ./module.nix;

    devShells = forAllSystems ({pkgs}: {
      default = {
        nativeBuildInputs = [
          nix-unit.packages.default
        ];
      };
    });
  };
}
