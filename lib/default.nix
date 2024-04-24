{
  lib,
  theme,
  ...
}: let
  colorsLib = import ./colors.nix {inherit lib theme;};
  templatesLib = import ./templates.nix {inherit lib theme;};
  fontsLib = import ./fonts.nix {inherit lib theme;};
in {
  inherit (colorsLib) mkRGBA mkRGB mkHex;

  inherit (templatesLib) mkTemplateContent;

  inherit (fontsLib) mkFont;
}
