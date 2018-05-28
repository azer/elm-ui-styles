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

# Reference

@docs autoGrid
@docs center
@docs circle
@docs cover
@docs equalGrid
@docs grid
@docs fullscreen
@docs maxWidth
@docs minWidth
@docs stretch

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


{-| Shortcut to set background image as cover
-}
cover : String -> List Css.Style -> List Css.Style
cover imageUrl list =
    List.append list
        [ Css.backgroundImage (Css.url imageUrl)
        , Css.backgroundSize Css.cover
        ]


{-| Make the element stretch to the visible part of the screen.
-}
fullscreen : List Css.Style -> List Css.Style
fullscreen list =
    List.append list
        [ Css.width (Css.pct 100)
        , Css.height (Css.vh 100)
        ]


type alias GridConfig =
    { columns : Length.Length
    , rows : Length.Length
    , columnGap : Length.Length
    , rowGap : Length.Length
    }


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


{-| Stretch the element to fill available horizontal and vertical space. In the other words, set the width / height to 100%.
-}
stretch list =
    List.append list
        [ Css.width (Css.pct 100)
        , Css.height (Css.pct 100)
        ]
