module Styles.Typography exposing (..)

{-| Module for configuring up fonts

# Definition

@docs Config

# Functions

@docs defaultConfig
@docs css

-}

import Styles.Length as Length
import Css

{-| Config for setting typography and basic text properties -}
type alias Config =
    { family : List String
    , size : Length.Length
    , weight : Int
    , height : Length.Length
    , uppercase : Bool
    , lowercase : Bool
    , capitalize : Bool
    , ellipsis : Bool
    , letterSpacing : Length.Length
    , fg : Css.Color
    , bg : Css.Color
    }

{-| Default typography config -}
defaultConfig : Config
defaultConfig =
    { family = []
    , size = Length.unset
    , weight = 0
    , height = Length.unset
    , uppercase = False
    , lowercase = False
    , capitalize = False
    , ellipsis = False
    , letterSpacing = Length.unset
    , fg = Css.hex ""
    , bg = Css.hex ""
    }

{-| Return CSS properties for given typography config -}
css : Config -> List Css.Style
css config  =
    []
    ++ (if List.length config.family == 0 then [] else [ Css.fontFamilies config.family ])
    ++ (if config.weight == 0 then [] else [ Css.property "font-weight" (toString config.weight) ])
    ++ (if config.letterSpacing == Length.unset then [] else [ Css.property "letter-spacing" (Length.stringify config.letterSpacing) ])
    ++ (if config.size == Length.unset then [] else [ Css.property "font-size" (Length.stringify config.size) ])
    ++ (if config.height == Length.unset then [] else [ Css.property "line-height" (Length.stringify config.height ) ])
    ++ (if config.uppercase == False then [] else [ Css.textTransform Css.uppercase ])
    ++ (if config.lowercase == False then [] else [ Css.textTransform Css.lowercase ])
    ++ (if config.capitalize == False then [] else [ Css.textTransform Css.capitalize ])
    ++ (if config.ellipsis == False then [] else [ Css.whiteSpace Css.noWrap, Css.overflow Css.hidden, Css.textOverflow Css.ellipsis ])
    ++ (if .value config.fg == "#"  then [] else [ Css.color config.fg ])
    ++ (if .value config.bg == "#" then [] else [ Css.color config.bg ])
