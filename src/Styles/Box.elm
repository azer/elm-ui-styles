module Styles.Box exposing (..)

{-| Module for configuring blocks

# Definition

@docs Config

-}

import Styles.Length as Length
import Css

{-| Options for creating a new element.
-}
type alias Config =
    { size : Length.Length
    , width : Length.Length
    , height : Length.Length
    , bg : Css.Color
    , fg : Css.Color
    }
