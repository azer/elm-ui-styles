# elm-ui-styles

Minimalist UI library for [elm-css](https://github.com/rtfeldman/elm-css), inspired by Tachyons. It consists of common styles to make frontend development straightforward using only Elm.

Usage Example ([Run it in Ellie](https://ellie-app.com/mMDGLSWLqGa1)):

```elm
import Styles exposing (..)
import Html.Styled exposing (header, section, h1, img, text)
import Html.Styled.Attributes exposing (css, src)

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
        
        
content =
    section []
        [ img [ src "https://placekitten.com/g/200/200", css (circle []) ] []
        , h1 [] [ text "Hello world" ]
        ]
```

See more examples under `examples` folder.

# Install

```bash
$ elm-package install azer/elm-ui-styles
```
