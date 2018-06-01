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

@docs autoGrid
@docs center
@docs circle
@docs cover
@docs debug
@docs debug16
@docs easein
@docs easeout
@docs equalGrid
@docs fullscreen
@docs defaultGrid
@docs grid
@docs GridConfig
@docs maxWidth
@docs minWidth
@docs maxWidth
@docs minWidth
@docs rainbow
@docs shadow
@docs stretch
@docs whitebg
@docs whitefg


# Helpers

@docs toCSS

-}

import Css
import Css.Media
import Html.Styled.Attributes as Attributes
import Html.Styled as Styled
import Styles.Length as Length


{-| Proxy function to `Html.Styled.Attributes.css`
-}
toCSS : List Css.Style -> Styled.Attribute msg
toCSS list =
    Attributes.css list


{-| Create a grid with given number auto-sized columns. It's equivalent of;

        grid { defaultGrid | columns = Length.repeat n Length.auto }

-}
autoGrid : Int -> List Css.Style -> List Css.Style
autoGrid n list =
    grid { defaultGrid | columns = Length.repeat n Length.auto } list


{-| Options for creating a new element.
-}
type alias BoxConfig =
    { size : Length.Length
    , width : Length.Length
    , height : Length.Length
    , bg : Css.Color
    , fg : Css.Color
    }


{-| Default box config
-}
defaultBox : BoxConfig
defaultBox =
    { size = Length.auto
    , width = Length.auto
    , height = Length.auto
    , bg = Css.hex "#fff"
    , fg = Css.hex "#000"
    }


{-| Create a new box element with given config
-}
box : BoxConfig -> List Css.Style -> List Css.Style
box config list =
    let
        width =
            if config.width == Length.auto then
                config.size
            else
                config.width

        height =
            if config.height == Length.auto then
                config.size
            else
                config.height
    in
        List.append list
            [ Css.boxSizing Css.borderBox
            , Css.display Css.block
            , Css.property "width" (Length.stringify width)
            , Css.property "height" (Length.stringify height)
            , Css.backgroundColor config.bg
            , Css.color config.fg
            ]


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


{-| Default gap config
-}
defaultGap : GapConfig
defaultGap =
    { inner = Length.auto
    , innerTop = Length.auto
    , innerRight = Length.auto
    , innerBottom = Length.auto
    , innerLeft = Length.auto
    , outer = Length.auto
    , outerTop = Length.auto
    , outerRight = Length.auto
    , outerBottom = Length.auto
    , outerLeft = Length.auto
    }


gap : GapConfig -> List Css.Style -> List Css.Style
gap config list =
    let
        map = List.map (\prop -> Css.property (.key prop) (Length.stringify (.value prop)))
        filter = List.filter (\prop -> (.value prop) /= Length.auto)
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

{-| Options for constructing new grid
-}
type alias GridConfig =
    { columns : Length.Length
    , rows : Length.Length
    , columnGap : Length.Length
    , rowGap : Length.Length
    }


{-| Default GridConfig
-}
defaultGrid : GridConfig
defaultGrid =
    { columns = Length.auto
    , rows = Length.auto
    , columnGap = Length.rem 1
    , rowGap = Length.rem 1
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
grid : GridConfig -> List Css.Style -> List Css.Style
grid config list =
    List.append list
        [ Css.property "display" "grid"
        , Css.property "grid-template-columns" (Length.stringify config.columns)
        , Css.property "grid-template-rows" (Length.stringify config.rows)
        , Css.property "grid-column-gap" (Length.stringify config.columnGap)
        , Css.property "grid-row-gap" (Length.stringify config.rowGap)
        , Css.property "justify-items" "stretch"
        , Css.property "align-items" "stretch"
        ]


{-| Shortcut for creating a grid with given number equal-sized columns. It's equivalent of;

        grid { defaultGrid | columns = Length.repeat n (Length.fr 1) }

-}
equalGrid : Int -> List Css.Style -> List Css.Style
equalGrid n list =
    grid { defaultGrid | columns = Length.repeat n (Length.fr 1) } list


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


{-| Add rainbow effect to the text.
-}
rainbow : List Css.Style -> List Css.Style
rainbow list =
    List.append list
        [ Css.property "background" "linear-gradient(330deg,#e05252,#99e052 25%,#52e0e0 50%,#9952e0 75%,#e05252)"
        , Css.property "-webkit-background-clip" "text"
        , Css.property "-webkit-text-fill-color" "transparent"
        ]


{-| Add shadow with specified opacity.
-}
shadow : Float -> List Css.Style -> List Css.Style
shadow opacity list =
    List.append list
        [ Css.property "box-shadow" ("0 0 4px 1px rgba(0,0,0," ++ (toString opacity) ++ ")") ]


{-| Stretch the element to fill available horizontal and vertical space. In the other words, set the width / height to 100%.
-}
stretch : List Css.Style -> List Css.Style
stretch list =
    List.append list
        [ Css.width (Css.pct 100)
        , Css.height (Css.pct 100)
        ]


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
