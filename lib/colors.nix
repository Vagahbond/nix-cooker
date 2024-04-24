{lib}: let
  hexToDec = import ./hex-to-dec.nix;

  parseHexByte = byte:
    (lib.lists.findSingle (n: n.hex == (builtins.substring 0 1 byte)) null null hexToDec).dec
    * 16
    + (lib.lists.findSingle (n: n.hex == (builtins.substring 1 1 byte)) null null hexToDec).dec;

  parseHex = hex: {
    r = parseHexByte (builtins.substring 1 2 hex);
    g = parseHexByte (builtins.substring 3 2 hex);
    b = parseHexByte (builtins.substring 5 2 hex);
    a =
      if builtins.stringLength hex > 7
      then parseHexByte (builtins.substring 7 2 hex)
      else 255;
  };

  normalizeRGB = color:
    if builtins.isString color
    then parseHex color
    else color;

  checkRGBAAlpha = n:
    if n > 1.0 || !builtins.isFloat
    then throw "Invalid value given for Alpha component"
    else n;

  getHexForDec = h: (lib.lists.findSingle (n: n.dec == h) null null hexToDec).hex;

  mkHex = n: "${getHexForDec (n / 16)}${getHexForDec (n - (16 * (n / 16)))}";

  normalizeHex = color:
    if builtins.isString color
    then color
    else "#${mkHex color.r}${mkHex color.g}${mkHex color.b}";

  checkHexAlpha = alpha:
    if builtins.match "[1-9a-fA-F]{2}"
    then alpha
    else throw "Invalid value given for Alpha component";
in {
  mkRGB = color: let nColor = normalizeRGB color; in "rgb(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b})";

  mkRGBA = color: alpha: let nColor = normalizeRGB color; in "rgba(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b}, ${builtins.toString checkRGBAAlpha alpha})";

  mkHHex = normalizeHex;
  mkHex = color: builtins.substring 1 6 (normalizeHex color);
  mkHHexA = color: alpha: "${normalizeHex color}${checkHexAlpha alpha}";
  mkHexA = color: alpha: "${mkHex color}${checkHexAlpha alpha}";
}
