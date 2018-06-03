module Styles.Color exposing (..)

{-| Color definition functions. All are proxy to elm-css.

# Proxy

@docs hex
@docs hsl
@docs hsla
@docs rgb
@docs rgba

-}

import Css

{-| Define hex color -}
hex : String -> Css.Color
hex string =
    Css.hex string


{-| Define hsl color -}
hsl : Float -> Float -> Float -> Css.Color
hsl h s l =
    Css.hsl h s l


{-| Define hsla color -}
hsla : Float -> Float -> Float -> Float -> Css.Color
hsla h s l a =
    Css.hsla h s l a


{-| Define rgb color -}
rgb : Int -> Int -> Int -> Css.Color
rgb r g b =
    Css.rgb r g b

{-| Define rgba color -}
rgba : Int -> Int -> Int -> Float -> Css.Color
rgba r g b a =
    Css.rgba r g b a
