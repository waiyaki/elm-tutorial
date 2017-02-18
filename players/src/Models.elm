module Models exposing (..)

import Players.Models exposing (Player)
import Routing


type alias NewPlayer =
    { name : String
    , level : Int
    }


type alias Model =
    { players : List Player
    , route : Routing.Route
    , newPlayer : NewPlayer
    }


initialModel : Routing.Route -> Model
initialModel route =
    { players = [], route = route, newPlayer = newPlayer }


newPlayer : NewPlayer
newPlayer =
    { name = "", level = 0 }
