module Main exposing (..)

import Styles exposing (..)
import Styles.Length exposing (px)
import Css
import Html.Styled exposing (div, text)
import List


main =
    div
        [ []
            |> box { defaultBox | size = px 250, bg = Css.hex "eee", fg = Css.hex "222" }
            |> gap { defaultGap | inner = px 10, outer = px 250 }
            |> center
            |> toCSS
        ]
        [ text "hey, this is a box" ]
        |> Html.Styled.toUnstyled
