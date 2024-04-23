{lib, ...}: let
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

  getHexForDec = h: (lib.lists.findSingle (n: n.dec == h) null null hexToDec).hex;

  mkHex = n: "${getHexForDec (n / 16)}${getHexForDec (n - (16 * (n / 16)))}";

  normalizeHex = color:
    if builtins.isString color
    then color
    else "#${mkHex color.r}${mkHex color.g}${mkHex color.b}";
in rec {
  mkTemplateContent = theme: contentFunction:
    contentFunction {
      inherit (theme) colors font;
      inherit mkRGB mkRGBA mkHex;
    };

  mkRGB = color: let nColor = normalizeRGB color; in "rgb(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b})";

  mkRGBA = color: let nColor = normalizeRGB color; in "rgba(${builtins.toString nColor.r}, ${builtins.toString nColor.g}, ${builtins.toString nColor.b}, ${builtins.toString nColor.a})";

  mkHex = color: {
    hashtag ? true,
    alpha ? false,
  }: let
    start =
      if hashtag
      then 0
      else 1;
    len =
      (
        if alpha
        then 9
        else 7
      )
      - start;
  in
    builtins.substring start len (normalizeHex color);
}
