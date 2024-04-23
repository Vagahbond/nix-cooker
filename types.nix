{lib, ...}: let
  rgbColorComponent = lib.types.ints.between 0 255;

  rgbColor = lib.types.submodule {
    options = {
      r = lib.mkOption {
        description = "The red component of the color";
        type = rgbColorComponent;
      };

      g = lib.mkOption {
        description = "The green component of the color";
        type = rgbColorComponent;
      };

      b = lib.mkOption {
        description = "The blue component of the color";
        type = rgbColorComponent;
      };

      a = lib.mkOption {
        default = 255;
        description = "The alpha component of the color";
        type = rgbColorComponent;
      };
    };
  };

  hexColor = lib.types.strMatching "^\#([0-9A-Fa-f]{2}){3,4}$";
in {
  color = lib.types.either rgbColor hexColor;
}
