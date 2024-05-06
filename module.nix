{
  config,
  lib,
  ...
}: let
  inherit (config) theme;
in {
  imports = [
    ./options.nix
  ];

  config = lib.mkIf (theme != null) {
    fonts.packages = [
      (lib.mkIf
        (theme.font.package != null)
        theme.font.package)

      (lib.mkIf
        (theme.symbolsFont.package != null)
        theme.symbolsFont.package)
    ];

    environment.systemPackages = [
      (lib.mkIf
        (theme.cursor.package != null)
        theme.cursor.package)

      (lib.mkIf
        (theme.gtkTheme.package != null)
        theme.gtkTheme.package)

      (lib.mkIf
        (theme.iconsTheme.package != null)
        theme.iconsTheme.package)

      (lib.mkIf
        (theme.displayManagerTheme.package != null)
        theme.displayManagerTheme.package)

      (lib.mkIf
        (theme.qtTheme.package != null)
        theme.qtTheme.package)

      (lib.mkIf
        (theme.wallpaper.package != null)
        theme.wallpaper.package)
    ];
  };
}
