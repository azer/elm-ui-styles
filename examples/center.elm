module Main exposing (..)

import Styles exposing (toCSS, center, stretch)
import Html.Styled exposing (div, text)
import List

main =
    div
        [ []
            |> center
            |> stretch
            |> toCSS
        ]
        [ text "hello world" ]
        |> Html.Styled.toUnstyled
