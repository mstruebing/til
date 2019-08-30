module Main exposing (main)

import Auth
import Browser
import Html exposing (Html)
import Learnings


type alias Model =
    { learnings : Learnings.Model
    , auth : Auth.Model
    }


type Msg
    = LearningsMsg Learnings.Msg
    | AuthMsg Auth.Msg


init : () -> ( Model, Cmd Msg )
init _ =
    let
        ( learningsModel, learningsCmd ) =
            Learnings.init

        ( authModel, authCmd ) =
            Auth.init
    in
    ( { learnings = learningsModel, auth = authModel }
    , Cmd.batch
        [ Cmd.map LearningsMsg <| learningsCmd
        , Cmd.map AuthMsg <| authCmd
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LearningsMsg subMsg ->
            let
                ( learningsModel, learnignsCmd ) =
                    Learnings.update subMsg model.learnings
            in
            ( { model | learnings = learningsModel }, Cmd.map LearningsMsg <| learnignsCmd )

        AuthMsg subMsg ->
            let
                ( authModel, authCmd ) =
                    Auth.update subMsg model.auth
            in
            ( { model | auth = authModel }, Cmd.map AuthMsg <| authCmd )


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
        , viewLoginForm model
        ]


viewLearnings : Model -> Html Msg
viewLearnings { learnings } =
    Html.map LearningsMsg <| Learnings.viewLearnings learnings


viewLearningCount : Model -> Html Msg
viewLearningCount { learnings } =
    Html.map LearningsMsg <| Learnings.viewLearningCount learnings


viewLoginForm : Model -> Html Msg
viewLoginForm _ =
    Html.map AuthMsg <| Auth.loginForm
