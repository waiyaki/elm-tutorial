module Players.Create exposing (create)

import Html exposing (Html, div, button, text, i, input, label)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onClick, onInput)
import Players.Nav
import Players.Messages exposing (Msg(..), NewPlayerMsg(..))


create : Html Msg
create =
    div []
        [ Players.Nav.nav
        , div [ class "p2 clearfix mxn2 md-mxn3" ]
            [ div [ class "col col-6 px2 md-px3" ]
                [ label [ class "label" ] [ text "Name" ]
                , Html.map AddNewPlayer nameInput
                , label [ class "label" ] [ text "Level" ]
                , Html.map AddNewPlayer levelInput
                , createBtn
                ]
            ]
        ]


nameInput : Html NewPlayerMsg
nameInput =
    input [ class "input", placeholder "Player Name", onInput Name ] []


levelInput : Html NewPlayerMsg
levelInput =
    input
        [ class "input"
        , placeholder "Player Level"
        , onInput
            (Level << Result.withDefault 0 << String.toInt)
        ]
        []


createBtn : Html Msg
createBtn =
    div []
        [ button [ class "btn btn-primary", onClick CreatePlayer ]
            [ i [ class "fa fa-plus mr1" ] []
            , text "Create"
            ]
        ]
