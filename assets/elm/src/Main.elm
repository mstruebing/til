module Main exposing (main)

import Browser
import Html exposing (Html)
import Learnings


type alias Model =
    { learnings : Learnings.Model }


type Msg
    = LearningsMsg Learnings.Msg


init : () -> ( Model, Cmd Msg )
init _ =
    let
        ( learningsModel, learningsCmd ) =
            Learnings.init
    in
    ( { learnings = learningsModel }, Cmd.map LearningsMsg <| learningsCmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LearningsMsg subMsg ->
            let
                ( learningsModel, learnignsCmd ) =
                    Learnings.update subMsg model.learnings
            in
            ( { model | learnings = learningsModel }, Cmd.map LearningsMsg <| learnignsCmd )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    Html.div []
        [ viewLearningCount model
        , viewLearnings model
        ]


viewLearnings : Model -> Html Msg
viewLearnings { learnings } =
    Html.map LearningsMsg <| Learnings.viewLearnings learnings


viewLearningCount : Model -> Html Msg
viewLearningCount { learnings } =
    Html.map LearningsMsg <| Learnings.viewLearningCount learnings
