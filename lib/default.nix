{
  lib,
  theme,
  ...
}: let
  colorsLib = import ./colors.nix {inherit lib;};
  templatesLib = import ./templates.nix {inherit lib theme;};
  fontsLib = import ./fonts.nix {inherit lib theme;};
in
  colorsLib // templatesLib // fontsLib
