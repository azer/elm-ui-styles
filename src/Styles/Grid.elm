module Styles.Grid exposing (..)

import Css
import Styles.Length as Length
import Styles.Align as Align

{-| Options for constructing new grid
-}
type alias Config =
    { columns : Length.Length
    , rows : Length.Length
    , columnGap : Length.Length
    , rowGap : Length.Length
    , justify : Align.Align
    , align : Align.Align
    }

{-| Default Config
-}
default : Config
default =
    { columns = Length.auto
    , rows = Length.auto
    , columnGap = Length.rem 1
    , rowGap = Length.rem 1
    , justify = Align.stretch
    , align = Align.stretch
    }


{-| Helper for creating CSS3 grid layouts. It takes a `GridConfig` type of record
and returns list of styles that you can pass to elm-css.

        import Styles exposing (grid, defaultGrid)
        import Styles.Length exposing (Pct)
        import Css exposing (css)

        main =
           let
             config = { defaultGrid | columns = List [Pct 30, Auto, Pct 30] }
           in
             div [ css (grid config []) ]
                 [ div [] [text "left (30%)"]
                 , div [] [text "center (auto)"]
                 , div [] [text "right (30%)"]
                 ]

-}
css : Config -> List Css.Style
css config =
        [ Css.property "display" "grid"
        , Css.property "grid-template-columns" (Length.stringify config.columns)
        , Css.property "grid-template-rows" (Length.stringify config.rows)
        , Css.property "grid-column-gap" (Length.stringify config.columnGap)
        , Css.property "grid-row-gap" (Length.stringify config.rowGap)
        , Css.property "justify-items" (Align.stringify config.justify)
        , Css.property "align-items" (Align.stringify config.align)
        ]
