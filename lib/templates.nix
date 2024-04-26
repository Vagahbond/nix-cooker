{
  lib,
  theme,
}: {
  mkTemplateContent = contentFunction:
    contentFunction (theme // (import ./colors.nix {inherit lib;}) // (import ./fonts.nix {inherit lib theme;}));
}
