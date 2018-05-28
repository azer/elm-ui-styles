# elm-ui-styles

Minimalist UI library for [elm-css](https://github.com/rtfeldman/elm-css), inspired by Tachyons. It consists of common styles to make frontend development straightforward using only Elm.

Usage Example:

```elm
import Styles exposing (..)

main =
    header
        [ []
            |> cover "https://cldup.com/X45WwK6_8L.png"
            |> center
            |> fullscreen
            |> toCSS
        ]
        [ content ]
        |> Html.Styled.toUnstyled
```

See more examples under `examples` folder.

# Install

```bash
$ elm-package install azer/elm-ui-styles
```
