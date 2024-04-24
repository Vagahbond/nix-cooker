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
      else null
    } ${
      if bold
      then "Bold"
      else null
    } ${
      if italic
      then "Italic"
      else null
    }";
}
