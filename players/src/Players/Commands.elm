module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field, succeed)
import Players.Models exposing (Player, PlayerId)
import Players.Messages exposing (..)
import Models exposing (NewPlayer)
import Json.Encode as Encode


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)


detailUrl : PlayerId -> String
detailUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = detailUrl player.id
        , body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , timeout = Nothing
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list |> Encode.object


createPlayer : NewPlayer -> Cmd Msg
createPlayer newPlayer =
    createRequest newPlayer |> Http.send OnCreate


createRequest : NewPlayer -> Http.Request Player
createRequest newPlayer =
    Http.post fetchAllUrl (newPlayerEncoded newPlayer |> Http.jsonBody) memberDecoder


newPlayerEncoded : NewPlayer -> Encode.Value
newPlayerEncoded player =
    let
        list =
            [ ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list |> Encode.object


deleteRequest : PlayerId -> Http.Request PlayerId
deleteRequest playerId =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = detailUrl playerId
        , body = Http.emptyBody
        , expect = Http.expectStringResponse (\_ -> Ok playerId)
        , timeout = Nothing
        , withCredentials = False
        }


deletePlayer : PlayerId -> Cmd Msg
deletePlayer playerId =
    deleteRequest playerId |> Http.send OnDelete
