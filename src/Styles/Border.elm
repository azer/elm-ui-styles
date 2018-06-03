module Styles.Border exposing (Border)

{-| Union types for defining border.

# Definition
@docs Border

-}

import Styles.Length as Length
import Css

{-| Union type for specifying border size, color and style.
-}
type Border
    = Size Length.Length
    | Color Css.Color
    | Multiple Border
    | Default
    | None
    | Solid
    | Dashed
    | Dotted
    | Inset
    | Outset
    | Ridge
    | Groove

{-| Config type for defining  / outer gaps for elements.
-}
type alias Config =
    { around : Border
    , top : Border
    , right : Border
    , bottom : Border
    , left : Border
    , outline : Border
    }
