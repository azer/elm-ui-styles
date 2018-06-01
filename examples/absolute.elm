module Main exposing (..)

import Styles exposing (..)
import Styles.Length exposing (..)
import Css
import Html.Styled exposing (div, text)
import List


main =
    div
        [ []
            |> box { defaultBox | size = px 250, bg = Css.hex "fafafa", fg = Css.hex "333" }
            |> absolute { defaultPosition | top = pct 50, left = pct 50 }
            |> gap { defaultGap | outerLeft = px -125, outerTop = px -125 }
            |> rounded 10
            |> center
            |> shadow 0.16
            |> toCSS
        ]
        [ text "hey, this is a box." ]
        |> Html.Styled.toUnstyled
