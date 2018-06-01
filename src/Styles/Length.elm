module Styles.Length exposing (..)

{-| Flexible length module. Not as strict as elm-css.

      import Styles.Length exposing (..)

      columns [em 1, px 3, auto]

      repeat 3, (fr 1)

# Definition

@docs Length

# Functions

@docs around
@docs auto
@docs columns
@docs em
@docs fr
@docs len
@docs pct
@docs px
@docs rem
@docs repeat
@docs rows
@docs unset
@docs vh

# Internal

@docs stringify


-}

{-| Union type for all kinds of lengths -}
type Length
    = Auto
    | Em Float
    | Fr Float
    | Multiple (List Length)
    | Unset
    | Pct Float
    | Px Float
    | Rem Float
    | Repeat Int Length
    | Vh Float

{-| Alias function for constructing list of lengths -}
around : List Length -> Length
around list =
    Multiple list

{-| Returns Auto -}
auto : Length
auto =
    Auto

{-| Alias function for constructing list of lengths -}
columns : List Length -> Length
columns list =
    Multiple list

{-| Returns an em length for given number -}
em : Float -> Length
em n =
    Em n

{-| Returns an fr length for given number -}
fr : Float -> Length
fr n =
    Fr n

{-| Alias function for constructing list of lengths -}
len : List Length -> Length
len list =
    Multiple list


{-| Returns an percent length for given number -}
pct : Float -> Length
pct n =
    Pct n

{-| Returns an pixels length for given number -}
px : Float -> Length
px n =
    Px n

{-| Returns an rem length for given number -}
rem : Float -> Length
rem n =
    Rem n

{-| Returns repeat of given length. -}
repeat : Int -> Length -> Length
repeat n len =
    Repeat n len

{-| Alias function for constructing list of lengths -}
rows : List Length -> Length
rows list =
    Multiple list

{-| Marks the property as unset -}
unset : Length
unset = Unset

{-| Returns vh length for given number. -}
vh : Float -> Length
vh n =
    Vh n

{-| Stringifies given length.

      > stringify (em 1)
      "1em"

      > stringify (columns [1em, auto, 1em])
      "1em auto 1em"
-}
stringify : Length -> String
stringify len =
    case len of
        Multiple all ->
            String.join " " (List.map stringify all)

        Repeat n len ->
            "repeat(" ++ (toString n) ++ "," ++ (stringify len) ++ ")"

        Px n ->
            (toString n) ++ "px"

        Em n ->
            (toString n) ++ "em"

        Rem n ->
            (toString n) ++ "rem"

        Vh n ->
            (toString n) ++ "vh"

        Fr n ->
            (toString n) ++ "fr"

        Pct n ->
            (toString n) ++ "%"

        Unset ->
            ""

        Auto ->
            "auto"
