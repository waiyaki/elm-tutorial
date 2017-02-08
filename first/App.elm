module App exposing (..)

import Html exposing (Html, program)
import Widget


-- MODEL


type alias AppModel =
    { widgetModel : Widget.Model
    }


initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel
    }


init : ( AppModel, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = WidgetMsg Widget.Msg



-- VIEW


view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.map WidgetMsg (Widget.view model.widgetModel) ]



-- UPDATE
{-
   When a WidgetMsg is received by update we delegate the update to the child component. But the child component will only update what it cares about, which is the widgetModel attribute.
   We use pattern matching to extract the subMsg from WidgetMsg. This subMsg will be the type that Widget.update expects.
   Using this subMsg and model.widgetModel we call Widget.update. This will return a tuple with an updated widgetModel and a command.
   We use pattern matching again to destructure the response from Widget.update.
   Finally we need to map the command returned by Widget.update to the right type. We use Cmd.map for this and tag the command with WidgetMsg, similar to what we did in the view.
-}


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
    case msg of
        WidgetMsg subMsg ->
            let
                ( updateWidgetModel, widgetCmd ) =
                    Widget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updateWidgetModel }, Cmd.map WidgetMsg widgetCmd )



-- SUBSCRIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN APP


main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
