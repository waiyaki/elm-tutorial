module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        PlayersMsg subMsg ->
            let
                ( updatedModel, cmd ) =
                    Players.Update.update subMsg model
            in
                ( updatedModel, Cmd.map PlayersMsg cmd )
