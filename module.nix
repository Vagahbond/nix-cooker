{
  lib,
  config,
  ...
}: let
in {
  imports = [
    ./options.nix
  ];
  config = {
    fonts.packages = [
      config.theme.font.package
    ];
  };
}
