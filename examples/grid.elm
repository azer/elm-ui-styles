module Main exposing (..)

import Styles exposing (..)
import Styles.Length exposing (columns, px, pct, auto)
import Html.Styled exposing (div, text)
import Css exposing (backgroundColor, hex)
import List


main =
    div
        [ []
            |> grid { defaultGrid | columns = columns [ px 250, auto, pct 20 ] }
            |> toCSS
        ]
        [ div [ bg "#ff0000" ] [ text "left 250px" ]
        , div [ bg "#00aa00" ] [ text "center auto" ]
        , div [ bg "#0000ff" ] [ text "right 20%" ]
        ]
        |> Html.Styled.toUnstyled


bg color =
    toCSS [ backgroundColor (hex color) ]
