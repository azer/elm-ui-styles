module Styles.Align exposing (..)

{-| Unfortunately elm-css doesn't expose its types, so, here we are.

# Functions

@docs unset
@docs left
@docs right
@docs center
@docs justify
@docs justifyAll
@docs start
@docs stretch
@docs end
@docs matchParent

# Definition

@docs Align

# Internal Functions

@docs stringify

-}

{-| Union type for all kinds of aligns -}
type Align
    = Unset
    | Left
    | Right
    | Center
    | Justify
    | JustifyAll
    | Start
    | Stretch
    | End
    | MatchParent

{-| unset -}
unset : Align
unset =
    Unset

{-| left -}
left : Align
left =
    Left

{-| right -}
right : Align
right =
    Right

{-| center -}
center : Align
center =
    Center


{-| justify -}
justify : Align
justify =
    Justify

{-| justifyAll -}
justifyAll : Align
justifyAll =
    JustifyAll

{-| start -}
start : Align
start =
    Start

{-| stretch -}
stretch : Align
stretch =
    Stretch

{-| End -}
end : Align
end =
    End

{-| MatchParent -}
matchParent : Align
matchParent =
    MatchParent

{-| Stringifies given align

      > stringify justify
      "justify"

      > stringify matchParent
      "match-parent"
-}
stringify : Align -> String
stringify align =
    case align of
        Unset ->
            "unset"

        Left ->
            "left"

        Right ->
            "right"

        Center ->
            "center"

        Justify ->
            "justify"

        JustifyAll ->
            "justify-all"

        Start ->
            "start"

        Stretch ->
            "stretch"

        End ->
            "end"

        MatchParent ->
            "match-parent"
