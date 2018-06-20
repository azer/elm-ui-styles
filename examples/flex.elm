module Main exposing (..)

import Styles exposing (..)
import Styles.Length exposing (..)
import Styles.Align as Align
import Styles.Color exposing (hex)
import Html.Styled exposing (div, text)
import Css exposing (backgroundColor)
import List


{-
   https://css-tricks.com/auto-sizing-columns-css-grid-auto-fill-vs-auto-fit/
-}


main =
    div
        [ []
            |> flex { defaultFlex | justifyContent = Align.flexEnd }
            |> toCSS
        ]
        [ child 1
        , child 2
        , child 3
        , child 4
        , child 5
        , child 6
        , child 7
        , child 8
        ]
        |> Html.Styled.toUnstyled

child n =
    div
        [ []
            |> box { defaultBox | bg = hex "ff00ff", fg = hex "fff" }
            |> gap { defaultGap | inner = px 20, outer = px 5 }
            |> toCSS
        ]
        [ text (toString n) ]


bg color =
    toCSS [ backgroundColor (hex color) ]
