module Main exposing (..)

import Styles exposing (minWidth, maxWidth)
import Html.Styled exposing (div, text)
import Html.Styled.Attributes exposing (css)
import Css exposing (backgroundColor, hex)


main =
    div
        [ [ backgroundColor (hex "#cc0000") ]
            |> minWidth 500 [ backgroundColor (hex "#38C172") ]
            |> css
        ]
        [ text "hello world" ]
        |> Html.Styled.toUnstyled
