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
    then parseHex (lib.strings.toUpper color)
    else color;

  checkRGBAAlpha = n:
    if n > 1.0 || !builtins.isFloat n
    then throw "Invalid value given for Alpha component"
    else n;

  getHexForDec = d: (lib.lists.findSingle (n: n.dec == d) null null hexToDec).hex;

  parseDec = n: "${getHexForDec (n / 16)}${getHexForDec (n - (16 * (n / 16)))}";

  normalizeHex = color:
    if builtins.isString color
    then color
    else "#${parseDec color.r}${parseDec color.g}${parseDec color.b}";

  checkHexAlpha = alpha:
    if builtins.match "[1-9a-fA-F]{2}" alpha != null
    then alpha
    else throw "Invalid value given for Alpha component";
in rec {
  mkRGB = color:
    if color == null
    then throw "Color cannot be null"
    else let nColor = normalizeRGB color; in "rgb(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b})";

  mkRGBA = color: alpha:
    if color == null
    then throw "Color cannot be null"
    else let nColor = normalizeRGB color; in "rgba(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b}, ${builtins.toString (checkRGBAAlpha alpha)})";

  mkHHex = color:
    if color == null
    then throw "Color cannot be null"
    else normalizeHex;

  mkHex = color:
    if color == null
    then throw "Color cannot be null"
    else builtins.substring 1 6 (normalizeHex color);

  mkHHexA = color: alpha:
    if color == null
    then throw "Color cannot be null"
    else "${normalizeHex color}${checkHexAlpha alpha}";

  mkHexA = color: alpha:
    if color == null
    then throw "Color cannot be null"
    else "${mkHex color}${checkHexAlpha alpha}";
}
