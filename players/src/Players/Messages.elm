module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type NewPlayerMsg
    = Name String
    | Level Int


type Msg
    = OnFetchAll (Result Http.Error (List Player))
    | ShowPlayers
    | ShowPlayer PlayerId
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
    | ShowCreatePage
    | CreatePlayer
    | AddNewPlayer NewPlayerMsg
    | OnCreate (Result Http.Error Player)
    | DeletePlayer PlayerId
    | OnDelete (Result Http.Error PlayerId)
