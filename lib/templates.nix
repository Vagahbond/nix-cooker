{
  lib,
  theme,
}: {
  mkTemplateContent = contentFunction:
    contentFunction {
      inherit (theme) colors font;
      inherit (import ./colors.nix {inherit lib;}) mkRGB mkRGBA mkHex;
      inherit (import ./fonts.nix {inherit lib theme;}) mkFontName;
    };
}
