{
  description = "Manage your rices !";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    lib = import ./lib;

    nixosModules.default = import ./module.nix;
  };
}
