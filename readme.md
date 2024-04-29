# Nix-cooker

**Beware, this software is WIP**
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
    colors = rec {
      base00 = {
        r = 253;
        g = 253;
        b = 253;
      };
      base01 = "#AABBCC";
      # ... other colors
      good = base00;

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
  mkHHex,
  mkHexA,
  mkHHexA,
  mkFontName,
}: ''
  Hello this is a template

  This example's used parameters are an exhaustive list

  ${mkRGB colors.base00} will provide "rgb(255, 255, 255)"

  ${mkRGBA colors.base00 1.0} will provide "rgba(255, 255. 255. 255)"

  ${mkHex colors.good} will provide "FFFFFF"

  ${mkHHex colors.base00 } will provide "#FFFFFF"

  ${mkHHexA colors.base00 "FF"} will provide "#FFFFFFFF"

  ${mkHexA colors.base00 "FF"} will provide "FFFFFFFF"

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

Then, you can reference it this way :

### Available functions

Several functions are usable imported from `inputs.nix-cooker.lib`.

Here are their description.

Mind you:
A `color` here references the colors saved in `theme.colors.<color name>` in your config, whether it be in hex or RGB format.

| Function          | Args                                                                                                                     | Example return value                  | Desc                                                                                                         |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| mkRGB             | A color                                                                                                                  | rgb(0, 0, 0)                          | Expresses a color in css rgb format                                                                          |
| mkRGBA            | A color and float alpha value                                                                                            | rgba(0, 0, 0, 0)                      | Expresses a color in css rgba format                                                                         |
| mkHex             | A color                                                                                                                  | FFFFFF                                | Builds an hexadecimal expression of the color, without the `#`.                                              |
| mkHexA            | A color and a hex alpha value                                                                                            | FFFFFFFF                              | Builds an hexadecimal expression of the color, with an added alpha channel and without the `#`.              |
| mkHHex            | A color                                                                                                                  | #FFFFFF                               | Builds an hexadecimal expression of the color, with the `#`.                                                 |
| mkHHexA           | A color and the hex alpha value                                                                                          | #FFFFFFFF                             | Builds an hexadecimal expression of the color, with an added alpha channel and with the `#`.                 |
| mkFontName        | An optional font name that defaults to the theme-defined one. Available flags are `mono`, `propo`, `bold`, and `italic`. | Terminess Propo Bold Italic           | Facilitates the generation of a string decribing a font name based on the font family name.                  |
| mkTemplateContent | A template as described above, which is a function returning a string.                                                   | _A string generated from the temlate_ | Allows injecting necessary arguments to a template and generating it. This is just a helper for convenience. |

## Why though ?

My goal with my conf is being able to manage several hosts as well as several themes or `rices`. Having a many-to-many relation with rices and hosts made the abstraction complicated so I figured it'd be good to have some kind of library to manage it all this is the one adressing the `rices`.

I tried several options available on github and none fullfilled my needs, so I descided to make one myself. It might not be better than the others. I made it the way I wanted it.

Thanks a lot to writers of my sources of inspiration :

- [Misterio77](https://github.com/Misterio77/nix-colors)

## Contributing ?

I am open to PRs, it'll be my pleasure to review yours.

### Next features

The following are the next features to be implemented. Add yours with a relevant issue or by contacting me somehow.

- [ ] Actualize documentation
- [ ] Scripts in templates | multi-files templates
- [ ] CI with checking and an auto generated documentation
- [ ] Home manager module -> light/dark theme switching
- [x] Wallpaper ?
- [x] Themes (cursor, GTK, SDDM)?
- [ ] Regular dotfiles generator
- [ ] Add dark/light themes functionalities ?
