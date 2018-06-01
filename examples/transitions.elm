module Main exposing (..)

import Styles exposing (..)
import Html.Styled exposing (div, h1, text)
import Html.Styled.Events exposing (onClick)
import Html
import Css exposing (width, height, px)
import Css.Foreign
import Css.Transitions exposing (easeIn, easeOut)


type Msg
    = Tap


main =
    Html.beginnerProgram
        { view = view
        , model = False
        , update = update
        }


update msg model =
    case msg of
        Tap ->
            not model


view model =
    div
        [ onClick Tap
        , []
            |> fullscreen
            |> center
            |> debug
            |> rainbow
            |> toCSS
        ]
        [ h1 [] [ text "He-yo, you can tap here." ]
        , messageView model
        , Css.Foreign.global
                [ Css.Foreign.selector "@keyframes sk-bouncedelay {\n 0%, 80%, 100%"
                      [ Css.property "transform" " scale(0);\n } 40% {\n transform scale(1.0);\n }" ]
                ]
        ]
        |> Html.Styled.toUnstyled


messageView model =
    div
        [ [ Css.padding2 (px 50) (px 100)
          , Css.position Css.absolute
          , Css.bottom
                (px
                    (if model then
                        100
                     else
                        -200
                    )
                )
          ]
            |> whitebg
            |> shadow 0.1
            |> (if model then
                    easein
                else
                    easeout
               )
                0.2
            |> toCSS
        ]
        [ text
            (if model then
                "ease-in"
             else
                "ease out"
            )
        ]
