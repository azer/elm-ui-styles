module Styles exposing (..)

{-| Styles is a UI library for [elm-css](https://github.com/rtfeldman/elm-css), inspired by [tachyons](http://tachyons.io).


# Usage Example

Making an element full-size, centering its content and making the text uppercase;

        import Styles exposing (toCSS, center, stretch)
        import Html.Styled exposing (div, text)
        import List

        main =
            div
                [ []
                    |> center
                    |> stretch
                    |> toCSS
                ]
                [ text "hello world" ]
                |> Html.Styled.toUnstyled


# Styling Reference

@docs absolute
@docs autoGrid
@docs box
@docs center
@docs circle
@docs cover
@docs debug
@docs debug16
@docs easein
@docs easeout
@docs equalGrid
@docs fixed
@docs flex
@docs fullscreen
@docs gap
@docs grid
@docs maxWidth
@docs monospace
@docs noborder
@docs nooutline
@docs minWidth
@docs position
@docs rainbow
@docs relative
@docs rounded
@docs sans
@docs serif
@docs shadow
@docs sticky
@docs stretch
@docs transparentBg
@docs typography
@docs whitebg
@docs whitefg


# Definition

@docs GapConfig
@docs PositionConfig


# Default Config

@docs defaultBox
@docs defaultFlex
@docs defaultGap
@docs defaultGrid
@docs defaultPosition
@docs defaultTypo


# Proxy

@docs toCSS

-}

import Css
import Css.Media
import Html.Styled.Attributes as Attributes
import Html.Styled as Styled
import Styles.Length as Length
import Styles.Typography as Typography
import Styles.Box as Box
import Styles.Grid as Grid


{-| Proxy function to `Html.Styled.Attributes.css`
-}
toCSS : List Css.Style -> Styled.Attribute msg
toCSS list =
    Attributes.css list


{-| Set position as absolute and pass position config
-}
absolute : PositionConfig -> List Css.Style -> List Css.Style
absolute config list =
    List.append list
        ([ Css.position Css.absolute ] ++ (position config))


{-| Create a grid with given number auto-sized columns. It's equivalent of;

        grid { defaultGrid | columns = Length.repeat n Length.auto }

-}
autoGrid : Int -> List Css.Style -> List Css.Style
autoGrid n list =
    grid { defaultGrid | columns = Length.repeatN n Length.auto } list

{-| Default box config
-}
defaultBox : Box.Config
defaultBox =
    Box.defaultConfig

{-| Create a new box element with given config
-}
box : Box.Config -> List Css.Style -> List Css.Style
box config list =
    List.append list (Box.css config)


{-| Centers inside the content.
-}
center : List Css.Style -> List Css.Style
center list =
    List.append list
        [ Css.property "display" "flex"
        , Css.justifyContent Css.center
        , Css.alignItems Css.center
        ]


{-| Make the element look circle.

        import Styles exposing (circle)
        import Html.Styled exposing (img)
        import Html.Styled.Attributes exposing (css, src)
        import Css exposing (backgroundColor, hex)


        main =
            img
                [ src "https://placekitten.com/g/200/200"
                , css (circle [])
                ]
                []
                |> Html.Styled.toUnstyled

-}
circle : List Css.Style -> List Css.Style
circle list =
    List.append list
        [ Css.borderRadius (Css.pct 100)
        ]


{-| Set given background image as cover
-}
cover : String -> List Css.Style -> List Css.Style
cover imageUrl list =
    List.append list
        [ Css.backgroundImage (Css.url imageUrl)
        , Css.backgroundSize Css.cover
        ]


{-| Shows 8px debug grid as a background.
-}
debug : List Css.Style -> List Css.Style
debug list =
    List.append list
        [ Css.backgroundImage (Css.url "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAAFElEQVR4AWPAC97/9x0eCsAEPgwAVLshdpENIxcAAAAASUVORK5CYII=") ]


{-| Shows 16px debug grid as a background.
-}
debug16 : List Css.Style -> List Css.Style
debug16 list =
    List.append list
        [ Css.backgroundImage (Css.url "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMklEQVR4AWOgCLz/b0epAa6UGuBOqQHOQHLUgFEDnAbcBZ4UGwDOkiCnkIhdgNgNxAYAiYlD+8sEuo8AAAAASUVORK5CYII=") ]


{-| Add easein transition to all properties
-}
easein : Float -> List Css.Style -> List Css.Style
easein time list =
    List.append list
        [ Css.property "transition" ((toString time) ++ "s" ++ " ease-in")
        ]


{-| Add easeout transition to all properties
-}
easeout : Float -> List Css.Style -> List Css.Style
easeout time list =
    List.append list
        [ Css.property "transition" ((toString time) ++ "s" ++ " ease-out")
        ]


{-| Set position as fixed and pass position config
-}
fixed : PositionConfig -> List Css.Style -> List Css.Style
fixed config list =
    List.append list
        ([ Css.position Css.fixed ] ++ (position config))

{-| Default flex box config
-}
defaultFlex : Box.Config
defaultFlex =
    let
        default = Box.defaultConfig
    in
        { default | flex = True }

{-| Create a new element with flex display -}
flex : Box.Config -> List Css.Style -> List Css.Style
flex config list = box config list

{-| Make the element stretch to the visible part of the screen.
-}
fullscreen : List Css.Style -> List Css.Style
fullscreen list =
    List.append list
        [ Css.width (Css.pct 100)
        , Css.height (Css.vh 100)
        ]


{-| Config type for defining inner / outer gaps for elements.
-}
type alias GapConfig =
    { inner : Length.Length
    , innerTop : Length.Length
    , innerRight : Length.Length
    , innerBottom : Length.Length
    , innerLeft : Length.Length
    , outer : Length.Length
    , outerTop : Length.Length
    , outerRight : Length.Length
    , outerBottom : Length.Length
    , outerLeft : Length.Length
    }

{-| Default Grid.Config
-}
defaultGrid : Grid.Config
defaultGrid = Grid.default

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
grid : Grid.Config -> List Css.Style -> List Css.Style
grid config list =
    List.append list (Grid.css config)

{-| Default gap config
-}
defaultGap : GapConfig
defaultGap =
    { inner = Length.unset
    , innerTop = Length.unset
    , innerRight = Length.unset
    , innerBottom = Length.unset
    , innerLeft = Length.unset
    , outer = Length.unset
    , outerTop = Length.unset
    , outerRight = Length.unset
    , outerBottom = Length.unset
    , outerLeft = Length.unset
    }


{-| Set inner (padding) and outer (margin) gap.-}
gap : GapConfig -> List Css.Style -> List Css.Style
gap config list =
    let
        map =
            List.map (\prop -> Css.property (.key prop) (Length.stringify (.value prop)))

        filter =
            List.filter (\prop -> (.value prop) /= Length.unset)

        props =
            [ { key = "padding", value = .inner config }
            , { key = "padding-top", value = .innerTop config }
            , { key = "padding-right", value = .innerRight config }
            , { key = "padding-bottom", value = .innerBottom config }
            , { key = "padding-left", value = .innerLeft config }
            , { key = "margin", value = .outer config }
            , { key = "margin-top", value = .outerTop config }
            , { key = "margin-right", value = .outerRight config }
            , { key = "margin-bottom", value = .outerBottom config }
            , { key = "margin-left", value = .outerLeft config }
            ]
    in
        List.append list
            (map (filter props))

{-| Shortcut for creating a grid with given number equal-sized columns. It's equivalent of;

        grid { defaultGrid | columns = Length.repeat n (Length.fr 1) }

-}
equalGrid : Int -> List Css.Style -> List Css.Style
equalGrid n list =
    grid { defaultGrid | columns = Length.repeatN n (Length.fr 1) } list


{-| Media query shortcut for defining styles that depend on maximum screen width (pixels).

        import Styles exposing (maxWidth, maxWidth)
        import Html.Styled exposing (div, text)
        import Html.Styled.Attributes exposing (css)
        import Css exposing (backgroundColor, hex)


        main =
            div
                [ [ backgroundColor (hex "#cc0000") ]
                    |> maxWidth 500 [ backgroundColor (hex "#38C172") ]
                    |> css
                ]
                [ text "hello world" ]
                |> Html.Styled.toUnstyled

-}

maxWidth : Float -> List Css.Style -> List Css.Style -> List Css.Style
maxWidth breakpoint styles list =
    List.append list
        [ Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (Css.px breakpoint) ] ]
            styles
        ]


{-| Media query shortcut for defining styles that depend on minimum screen width (pixels).

        import Styles exposing (minWidth, maxWidth)
        import Html.Styled exposing (div, text)
        import Html.Styled.Attributes exposing (css)
        import Css exposing (backgroundColor, hex)

        main =
            div
                [ [ backgroundColor (hex "#cc0000") ]
                    |> minWidth 500 [ backgroundColor (hex "#38C172") ]
                    |> css
                ]
                [ text "hello world" ]
                |> Html.Styled.toUnstyled

-}
minWidth : Float -> List Css.Style -> List Css.Style -> List Css.Style
minWidth breakpoint styles list =
    List.append list
        [ Css.Media.withMedia [ Css.Media.all [ Css.Media.minWidth (Css.px breakpoint) ] ]
            styles
        ]

{-| Set typography as monospace, proxying other typography options -}
monospace : Typography.Config -> List Css.Style -> List Css.Style
monospace config list =
    typography { config | family = ["Menlo", "Inconsolata", "Fira Mono", "Noto Mono", "Droid Sans Mono", "Consolas", "monaco" , "monospace"] } list

{-| Config for setting position. -}
type alias PositionConfig =
    { top : Length.Length
    , right : Length.Length
    , bottom : Length.Length
    , left : Length.Length
    }

{-| Remove the borders -}
noborder : List Css.Style -> List Css.Style
noborder list =
    List.append list
        [ Css.property "border" "none" ]

{-| Remove the outlines -}
nooutline : List Css.Style -> List Css.Style
nooutline list =
    List.append list
        [ Css.property "outline" "none" ]

{-| Default position config
-}
defaultPosition : PositionConfig
defaultPosition =
    { top = Length.unset
    , right = Length.unset
    , bottom = Length.unset
    , left = Length.unset
    }


{-| Set position properties "top" "left" "right" and "bottom"
-}
position : PositionConfig  -> List Css.Style
position config =
    let
        map =
            List.map (\prop -> Css.property (.key prop) (Length.stringify (.value prop)))

        filter =
            List.filter (\prop -> (.value prop) /= Length.unset)
    in
        (map << filter)
            [ { key = "top", value = .top config }
            , { key = "right", value = .left config }
            , { key = "bottom", value = .bottom config }
            , { key = "left", value = .left config }
            ]


{-| Add rainbow effect to the text.
-}
rainbow : List Css.Style -> List Css.Style
rainbow list =
    List.append list
        [ Css.property "background" "linear-gradient(330deg,#e05252,#99e052 25%,#52e0e0 50%,#9952e0 75%,#e05252)"
        , Css.property "-webkit-background-clip" "text"
        , Css.property "-webkit-text-fill-color" "transparent"
        ]


{-| Set position as relative and pass position config
-}
relative : PositionConfig -> List Css.Style -> List Css.Style
relative config list =
    List.append list
        ([ Css.position Css.relative ] ++ (position config))


{-| Set border as rounded with given pixels
-}
rounded : Length.Length -> List Css.Style -> List Css.Style
rounded len list =
    List.append list
        [ Css.property "border-radius" (Length.stringify len) ]


{-| Set typography family as sans, proxying other typography options -}
sans : Typography.Config -> List Css.Style -> List Css.Style
sans config list =
    typography { config | family = ["-apple-system", "BlinkMacSystemTypography", "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue", "sans-serif"] } list

{-| Set typography family as serif, proxying other typography options -}
serif : Typography.Config -> List Css.Style  -> List Css.Style
serif config list =
    typography { config | family = ["Apple Garamond", "Baskerville", "Times New Roman", "Droid Serif", "Times", "Source Serif Pro", "serif"] } list

{-| Add shadow with specified opacity.
-}
shadow : Float -> List Css.Style -> List Css.Style
shadow opacity list =
    List.append list
        [ Css.property "box-shadow" ("0 1px 3px 0 rgba(0,0,0," ++ (toString opacity) ++ ")") ]


{-| Set position as sticky and pass position config
-}
sticky : PositionConfig -> List Css.Style -> List Css.Style
sticky config list =
    List.append list
        ([ Css.position Css.sticky ] ++ (position config))


{-| Stretch the element to fill available horizontal and vertical space. In the other words, set the width / height to 100%.
-}
stretch : List Css.Style -> List Css.Style
stretch list =
    box { defaultBox | size = Length.pct 100 } list

{-| Shortcut for setting background as transparent
-}
transparentBg : List Css.Style -> List Css.Style
transparentBg list =
    List.append list
        [ Css.backgroundColor Css.transparent
        ]


{-| Default typography config -}
defaultTypo : Typography.Config
defaultTypo =
    Typography.defaultConfig

{-| Set typography options -}
typography : Typography.Config -> List Css.Style -> List Css.Style
typography config list =
    List.append list (Typography.css config)

{-| Shortcut for setting background color as white
-}
whitebg : List Css.Style -> List Css.Style
whitebg list =
    List.append list
        [ Css.backgroundColor (Css.hex "#fff")
        ]


{-| Shortcut for setting text color as white
-}
whitefg : List Css.Style -> List Css.Style
whitefg list =
    List.append list
        [ Css.color (Css.hex "#fff")
        ]
