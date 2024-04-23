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
    environment.sessionVariables = {
      TEST_COLOR = builtins.toJSON config.theme.colors;
    };
  };
}
