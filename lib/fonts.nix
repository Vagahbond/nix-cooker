{
  lib,
  theme,
}: {
  mkFontName = {
    fontName ? theme.font.name,
    mono ? false,
    propo ? false,
    bold ? false,
    italic ? false,
  }:
    if mono && propo
    then throw "Font cannot be both mono and propo !"
    else "${fontName} ${
      if mono
      then "Mono"
      else if propo
      then "Propo"
      else ""
    } ${
      if bold
      then "Bold"
      else ""
    } ${
      if italic
      then "Italic"
      else ""
    }";
}
