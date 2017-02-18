module Players.Nav exposing (nav)

import Html exposing (Html, div, button, text, i)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Players.Messages exposing (Msg(ShowPlayers))


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ] [ listBtn ]


listBtn : Html Msg
listBtn =
    button
        [ class "btn regular", onClick ShowPlayers ]
        [ i [ class "fa fa-chevron-left mr1" ] []
        , text "List"
        ]
