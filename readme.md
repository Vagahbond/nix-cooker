# Nix-cooker

**Beware, this software is WIP**
TODO:

- [ ] Colors aliases
- [ ] Fix alpha on rgba because I'm a darn idiot
- [ ] Documentation for referencing templates
- [ ] CI with checking and an auto generated documentation
- [ ] Wallpaper ?
- [ ] Themes (cursor, GTK, SDDM)?

A little help to cook your rices with nix.

Nix-Cooker aims to centralize your themes configs in one place, and allow having a separate batch of hosts, and homes.

It achieves this by storing your fonts, color schemes, and templates aside in centralized themes.

You can them reference those configured colors, templates, and fonts everywhere in your NixOS config.

Nix-cooker also provides a bunch of helper function to automatically generate any color format you need (rbg, hex, with or without `#` !). Those functions are made available in templates, but also in the rest of your configuration, to get that extra flexibility:tm: that you might need.

_Note that nix-cooker does not depend on home-manager or anything alike, it works as standalone._
Also note that nix-cooker does not provide the templates, you provide yours. Nix-cooker is a tool to manage your own theme and does not provide any.

## How to it works

First, import this flake in your system flake :

```nix
inputs.nix-cooker.url = "github:vagahbond/nix-cooker";
```

You must also pass your inputs to your config to be able to use nix-cooker's functions.

Example :

```nix
outputs = {self, ...} @ inputs: {
    # ...
};

```

### Create a theme

Different options are made available for you to create a theme.
A theme is a set of values for on this flake's options. To have several themes, simply chose which one to import in your config, the way you manage them is up to you.

Here is an example of a theme :

```nix
    theme = {
    colors = {
      base00 = {
        r = 253;
        g = 253;
        b = 253;
      };
      base01 = "#AABBCC";
      # ... other colors
    };

    font = {
      package = pkgs.nerdfonts.override {fonts = ["Terminus"];};
      name = "Terminess Nerd Font";
    };

    templates = {
      # ...
    };
  };
```

TODO: Manual

### Use templates

#### Create a template

Nix-cooker allows you to create templates for your conf files.

Templates are meant to be declared in separate files.

A template is a `function` to which several arguments, including logic and data, will be injected. Here is a minimal example :

```nix
{
  colors,
  font,
  mkRGB,
  mkRGBA,
  mkHex,
  mkFontName,
}: ''
  Hello this is a template

  This example's used parameters are an exhaustive list

  ${mkRGB colors.base00} will provide "rgb(255, 255, 255)"

  ${mkRGBA colors.base00} will provide "rgba(255, 255. 255. 255)"

  ${mkHex colors.base00 {
    alpha = true;
    hashtag = true;
  }} will provide "#FFFFFFFF"

  You can also get your font's name : ${font.name}

  But it can also be altered : ${(mkFontName {
    propo = true;
    bold = true;
    italic = true;
  })}
''
```

#### Use a template

Once your template is created, you must feed it to a function that's meant to evaluate it after injecting its arguments.

In your system config, import nix-cooker and define templates as such :

```nix
{inputs}: let
    inherit inputs.nix-cooker.lib.mkTemplateContent
in {
  imports = [
    inputs.nix-cooker.nixosModules.default
    ./options.nix
  ];

  config.theme.templates.hyprland = mkTemplateContent (import ./templates/hyprland.nix);
}

```

### Available functions

Several functions are usable imported from `inputs.nix-cooker.lib`.

Here are their description.

Mind you:
A `color` here references the colors saved in `theme.colors.<color name>` in your config, whether it be in hex or RGB format.

| Function          | Args                                                                                                                     | Example return value                  | Desc                                                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| mkRGB             | A color                                                                                                                  | rgb(0, 0, 0)                          | Expresses a color in css rgb format                                                                                        |
| mkRGBA            | A color                                                                                                                  | rgba(0, 0, 0, 0)                      | Expresses a color in css rgba format                                                                                       |
| mkHex             | A color, and then `alpha` and `hashtag` optional flags that you can enable or disable.                                   | #FFFFFF or #FFFFFFFF or FFFFFF        | Expresses a color in hexadecimal format, with a possibility to remove the `#` or include the alpha channel(defaults to 1). |
| mkFontName        | An optional font name that defaults to the theme-defined one. Available flags are `mono`, `propo`, `bold`, and `italic`. | Terminess Propo Bold Italic           | Facilitates the generation of a string decribing a font name based on the font family name.                                |
| mkTemplateContent | A template as described above, which is a function returning a string.                                                   | _A string generated from the temlate_ | Allows injecting necessary arguments to a template and generating it. This is just a helper for convenience.               |

## Why though ?

I tried several options available on github and none fullfilled my needs, so I descided to make one myself. It might not be better than the others. I made it the way I wanted it.

Thanks a lot to writers of my sources of inspiration :

- [RGBCube](https://github.com/RGBCube/ThemeNix)
- [Misterio77](https://github.com/Misterio77/nix-colors)

## Contributing ?

I am open to PRs, it'll be my pleasure to review yours.
