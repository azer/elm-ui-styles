module Main exposing (..)

import Styles exposing (..)
import Html.Styled exposing (div, text)
import Html.Styled.Attributes exposing (css)
import Css exposing (backgroundColor, hex, width, px)
import List


main =
    div
        [ css (autoGrid 3 []) ]
        [ div [ bg "#ff0000" ] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit." ]
        , div [ bg "#00aa00" ] [ text "Donec eleifend ipsum eu arcu imperdiet" ]
        , div [ bg "#0000ff" ] [ text "Praesent arcu odio " ]
        ]
        |> Html.Styled.toUnstyled


bg color =
    css [ backgroundColor (hex color) ]
