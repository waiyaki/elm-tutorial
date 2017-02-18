module Players.Update exposing (..)

import Navigation
import Players.Messages exposing (Msg(..), NewPlayerMsg(..))
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save, createPlayer, deletePlayer)
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok newPlayers) ->
            ( { model | players = newPlayers }, Cmd.none )

        OnFetchAll (Err error) ->
            let
                err =
                    Debug.log "error" error
            in
                ( model, Cmd.none )

        ShowPlayers ->
            ( model, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( model, Navigation.newUrl ("#players/" ++ id) )

        ChangeLevel id howMuch ->
            ( model, changeLevelCommands id howMuch model.players |> Cmd.batch )

        OnSave (Ok updatedPlayer) ->
            ( { model | players = (updatePlayer updatedPlayer model.players) }, Cmd.none )

        OnSave (Err error) ->
            let
                err =
                    Debug.log "OnSave error: " error
            in
                ( model, Cmd.none )

        OnCreate (Ok newPlayer) ->
            ( { model
                | players = List.append model.players [ newPlayer ]
              }
            , Navigation.newUrl ("#players/" ++ newPlayer.id)
            )

        OnCreate (Err error) ->
            ( model, Cmd.none )

        ShowCreatePage ->
            ( model, Navigation.newUrl "#create" )

        CreatePlayer ->
            ( model, createPlayer model.newPlayer )

        AddNewPlayer msg ->
            case msg of
                Name name ->
                    let
                        player =
                            model.newPlayer

                        newPlayer =
                            { player | name = name }
                    in
                        ( { model | newPlayer = newPlayer }, Cmd.none )

                Level level ->
                    let
                        player =
                            model.newPlayer

                        newPlayer =
                            { player | level = level }
                    in
                        ( { model | newPlayer = newPlayer }, Cmd.none )

        DeletePlayer playerId ->
            ( model, deletePlayer playerId )

        OnDelete (Ok playerId) ->
            let
                players =
                    List.filter (\p -> p.id /= playerId) model.players
            in
                ( { model | players = players }, Navigation.newUrl "#players" )

        OnDelete (Err error) ->
            let
                err =
                    Debug.log "Error Deleting player" error
            in
                ( model, Cmd.none )


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players


updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
