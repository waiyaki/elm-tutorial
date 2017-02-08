module Increment exposing (..)

import Html exposing (Html, program, div, button, text, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (type_, value)
import String


-- MODEL


type alias Model =
    { currentValue : Int
    , howMuch : Int
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model 0 2, Cmd.none )



-- MESSAGES


type Msg
    = Increment Int
    | Decrement Int
    | HowMuch String
    | Reset



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick (Increment model.howMuch) ] [ text "+" ]
            , text (toString model.currentValue)
            , button [ onClick (Decrement model.howMuch) ] [ text "-" ]
            ]
        , div []
            [ text "Change By: "
            , input
                [ type_ "text"
                , value (toString model.howMuch)
                , onInput HowMuch
                ]
                []
            ]
        , div []
            [ button [ onClick Reset ] [ text "Reset" ] ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( { model | currentValue = model.currentValue + howMuch }, Cmd.none )

        Decrement howMuch ->
            ( { model | currentValue = model.currentValue - howMuch }, Cmd.none )

        HowMuch value ->
            let
                nextValue =
                    Result.withDefault model.howMuch (String.toInt value)
            in
                ( { model | howMuch = nextValue }, Cmd.none )

        Reset ->
            ( Model 0 2, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
