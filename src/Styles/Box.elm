module Styles.Box exposing (..)

{-| Module for configuring blocks


# Definition

@docs Config


# Functions

@docs css
@docs defaultConfig

-}

import Styles.Length as Length
import Styles.Align as Align
import Css


{-| Options for creating a new element.
-}
type alias Config =
    { size : Length.Length
    , width : Length.Length
    , height : Length.Length
    , bg : Css.Color
    , fg : Css.Color
    , block : Bool
    , inline : Bool
    , inlineBlock : Bool
    , flex : Bool
    , alignContent : Align.Align
    , justifyContent : Align.Align
    , alignItems : Align.Align
    , justifyItems : Align.Align
    }


{-| Default box config
-}
defaultConfig : Config
defaultConfig =
    { size = Length.unset
    , width = Length.unset
    , height = Length.unset
    , bg = Css.hex ""
    , fg = Css.hex ""
    , block = False
    , inline = False
    , inlineBlock = False
    , flex = False
    , alignContent = Align.unset
    , justifyContent = Align.unset
    , alignItems = Align.unset
    , justifyItems = Align.unset
    }


{-| Return CSS properties for given config
-}
css : Config -> List Css.Style
css config =
    let
        width =
            if config.width == Length.unset then
                config.size
            else
                config.width

        height =
            if config.height == Length.unset then
                config.size
            else
                config.height
    in
        [ Css.boxSizing Css.borderBox ]
            ++ (if width /= Length.unset then
                    [ Css.property "width" (Length.stringify width) ]
                else
                    []
               )
            ++ (if height /= Length.unset then
                    [ Css.property "height" (Length.stringify height) ]
                else
                    []
               )
            ++ (if .value config.bg /= "#" then
                    [ Css.backgroundColor config.bg ]
                else
                    []
               )
            ++ (if .value config.fg /= "#" then
                    [ Css.color config.fg ]
                else
                    []
               )
            ++ (if config.block then
                    [ Css.display Css.block ]
                else
                    []
               )
            ++ (if config.inline then
                    [ Css.display Css.inline ]
                else
                    []
               )
            ++ (if config.inlineBlock then
                    [ Css.display Css.inlineBlock ]
                else
                    []
               )
            ++ (if config.flex then
                    [ Css.property "display" "flex" ]
                else
                    []
               )
            ++ (if config.justifyItems /= Align.unset then
                    [ Css.property "justify-items" (Align.stringify config.justifyItems) ]
                else
                    []
               )
            ++ (if config.justifyContent /= Align.unset then
                    [ Css.property "justify-content" (Align.stringify config.justifyContent) ]
                else
                    []
               )
            ++ (if config.alignItems /= Align.unset then
                    [ Css.property "align-items" (Align.stringify config.alignItems) ]
                else
                    []
               )
            ++ (if config.alignContent /= Align.unset then
                    [ Css.property "align-content" (Align.stringify config.alignContent) ]
                else
                    []
               )
