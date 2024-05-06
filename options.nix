{
  lib,
  pkgs,
  config,
  ...
}: let
  mTypes = import ./types.nix {inherit lib;};
in {
  options.theme = lib.mkOption {
    description = "A set of options defining a theme";
    default = null;
    type = lib.types.nullOr (lib.types.submodule {
      options = {
        font = {
          package = lib.mkOption {
            description = "The package for the font used in this theme.";
            default = null;
            example = pkgs.fira-code;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the font.";
            default = "";
            example = "Terminess Nerd Font";
            type = lib.types.str;
          };
        };

        cursor = {
          package = lib.mkOption {
            description = "The package for the cursor used in this theme.";
            default = null;
            example = pkgs.bibata-cursors;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the cursor.";
            default = "";
            example = "Bibata";
            type = lib.types.str;
          };
        };

        gtkTheme = {
          package = lib.mkOption {
            description = "The package for the GTK theme used in this theme.";
            default = null;
            example = pkgs.catppuccin-gtk;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the GTK theme.";
            default = "";
            example = "Catppuccin-Mocha-Mauve-Dark";
            type = lib.types.str;
          };
        };

        iconsTheme = {
          package = lib.mkOption {
            description = "The package for the icons theme used in this theme.";
            default = null;
            example = pkgs.catppuccin-papirus-folders;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the icons theme.";
            default = "";
            example = "Papirus-Dark";
            type = lib.types.str;
          };
        };

        displayManagerTheme = {
          package = lib.mkOption {
            description = "The package for the display manager theme used in this theme.";
            default = null;
            example = pkgs.catppuccin-gtk;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the display manager theme.";
            default = "";
            example = "Catppuccin-Mocha-Mauve-Dark";
            type = lib.types.str;
          };
        };

        wallpaper = {
          package = lib.mkOption {
            description = "A package containing the wallpaper.";
            default = null;
            example = pkgs.catppuccin-gtk;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the wallpaper file.";
            default = "wallpaper.jpg";
            example = "cringeanimewallpaper.jpg";
            type = lib.types.str;
          };
        };

        qtTheme = {
          package = lib.mkOption {
            description = "The package for the QT theme used in this theme.";
            default = null;
            example = pkgs.catppuccin-qt5ct;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the QT theme.";
            default = "";
            example = "Catppuccin-Mocha-Mauve-Dark";
            type = lib.types.str;
          };
        };

        symbolsFont = {
          package = lib.mkOption {
            description = "The package for the symbols font used for this theme.";
            default = null;
            example = pkgs.material-icons;
            type = lib.types.nullOr lib.types.package;
          };

          name = lib.mkOption {
            description = "Name for the font.";
            default = "";
            example = "Material Icons";
            type = lib.types.str;
          };
        };

        templates = lib.mkOption {
          description = "Store a template to use it in your conf.";
          default = {};
          type = lib.types.attrsOf lib.types.str;
        };

        colors = {
          base00 = lib.mkOption {
            description = "Default Background";
            default = "#181818";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base01 = lib.mkOption {
            description = "Lighter Background (Used for status bars, line number and folding marks)";
            default = "#282828";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base02 = lib.mkOption {
            description = "Selection Background";
            default = "#383838";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base03 = lib.mkOption {
            description = "Comments, Invisibles, Line Highlighting";
            default = "#585858";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base04 = lib.mkOption {
            description = "Dark Foreground (Used for status bars)";
            default = "#b8b8b8";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base05 = lib.mkOption {
            description = "Default Foreground, Caret, Delimiters, Operators";
            default = "#d8d8d8";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base06 = lib.mkOption {
            description = "Light Foreground (Not often used)";
            default = "#e8e8e8";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base07 = lib.mkOption {
            description = "Light Background (Not often used)";
            default = "#f8f8f8";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base08 = lib.mkOption {
            description = "Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted";
            default = "#ab4642";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base09 = lib.mkOption {
            description = "Integers, Boolean, Constants, XML Attributes, Markup Link Url";
            default = "#dc9656";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0A = lib.mkOption {
            description = "Classes, Markup Bold, Search Text Background";
            default = "#f7ca88";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0B = lib.mkOption {
            description = "Strings, Inherited Class, Markup Code, Diff Inserted";
            default = "#a1b56c";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0C = lib.mkOption {
            description = "Support, Regular Expressions, Escape Characters, Markup Quotes";
            default = "#86c1b9";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0D = lib.mkOption {
            description = "Functions, Methods, Attribute IDs, Headings";
            default = "#7cafc2";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0E = lib.mkOption {
            description = "Keywords, Storage, Selector, Markup Italic, Diff Changed";
            default = "#ba8baf";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };
          base0F = lib.mkOption {
            description = "Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>";
            default = "#a16946";
            example = {
              r = 255;
              g = 0;
              b = 255;
            };
            type = mTypes.color;
          };

          good = lib.mkOption {
            description = "Alias for your sementically good color";
            default = config.theme.colors.base0B;
            example = "#FFFFFF";
            type = mTypes.color;
          };
          warning = lib.mkOption {
            description = "Alias for your color that signifies a warning";
            default = config.theme.colors.base09;
            example = "#FFFFFF";
            type = mTypes.color;
          };
          bad = lib.mkOption {
            description = "Alias for your color that signifies an error or a bad thing (EG: empty battery)";
            default = config.theme.colors.base08;
            example = "#FFFFFF";
            type = mTypes.color;
          };

          accent = lib.mkOption {
            description = "The color that you want to use as an accent for your theme";
            default = config.theme.colors.base0B;
            example = "#FFFFFF";
            type = mTypes.color;
          };
          background = lib.mkOption {
            description = "The color that you want to use as an accent for your theme";
            default = config.theme.colors.base00;
            example = "#FFFFFF";
            type = mTypes.color;
          };
          text = lib.mkOption {
            description = "The color that you want to use as an accent for your theme";
            default = config.theme.colors.base04;
            example = "#FFFFFF";
            type = mTypes.color;
          };

          custom = lib.mkOption {
            description = "Custom aliases that you might want to use for your own theme.";
            default = {};
            example = {};
            type = lib.types.attrsOf mTypes.color;
          };
        };

        radius = lib.mkOption {
          description = "Radius for corners of apps across system";
          default = 6;
          example = 6;
          type = lib.types.int;
        };
      };
    });
  };
}
