module Main exposing (..)

import Styles exposing (..)
import Html.Styled exposing (header, section, h1, img, text)
import Html.Styled.Attributes exposing (css, src)
import Css


main =
    header
        [ []
            |> cover "https://cldup.com/X45WwK6_8L.png"
            |> center
            |> fullscreen
            |> serif { defaultTypo | capitalize = True, fg = Css.hex "#fff" }
            |> css
        ]
        [ content ]
        |> Html.Styled.toUnstyled

content =
    section []
        [ img [ src "https://placekitten.com/g/200/200", css (circle []) ] []
        , h1 [] [ text "Hello world" ]
        ]
