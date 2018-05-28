module Styles.Length exposing (..)


type Length
    = Auto
    | Em Float
    | Fr Float
    | Multiple (List Length)
    | Pct Float
    | Px Float
    | Rem Float
    | Repeat Int Length
    | Vh Float

around : List Length -> Length
around list =
    Multiple list

auto : Length
auto =
    Auto


columns : List Length -> Length
columns list =
    Multiple list


em : Float -> Length
em n =
    Em n


fr : Float -> Length
fr n =
    Fr n


pct : Float -> Length
pct n =
    Pct n


px : Float -> Length
px n =
    Px n

rem : Float -> Length
rem n =
    Rem n

repeat : Int -> Length -> Length
repeat n len =
    Repeat n len

rows : List Length -> Length
rows list =
    Multiple list

vh : Float -> Length
vh n =
    Vh n


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

        Auto ->
            "auto"
