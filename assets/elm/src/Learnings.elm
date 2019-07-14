module Learnings exposing
    ( Learning
    , LearningCount
    , Model
    , Msg(..)
    , getLearningCount
    , getLearnings
    , init
    , initLearningCount
    , initLearnings
    , learningCountQuery
    , learningSelection
    , learningsQuery
    , update
    , viewLearning
    , viewLearningCount
    , viewLearnings
    )

import Api.Object
import Api.Object.Learning as Learning
import Api.Query as Query
import Graphql.Http exposing (queryRequest, send)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (Html)
import Html.Events exposing (onClick)
import Shared exposing (graphqlServerUrl)


type alias Model =
    { learnings : List Learning
    , learningCount : LearningCount
    }


type alias Learning =
    { content : String
    , tags : List String
    }


type alias LearningCount =
    Int


initLearningCount : Int
initLearningCount =
    0


initLearnings : List Learning
initLearnings =
    []


init : ( Model, Cmd Msg )
init =
    ( { learnings = initLearnings, learningCount = initLearningCount }, Cmd.batch [ getLearnings, getLearningCount ] )


learningCountQuery : SelectionSet Int RootQuery
learningCountQuery =
    Query.learningCount


learningsQuery : SelectionSet (List Learning) RootQuery
learningsQuery =
    Query.learnings learningSelection


learningSelection : SelectionSet Learning Api.Object.Learning
learningSelection =
    SelectionSet.map2 Learning
        Learning.content
        Learning.tags


type Msg
    = GotLearnings (Result (Graphql.Http.Error (List Learning)) (List Learning))
    | GetLearningCount
    | GotLearningCount (Result (Graphql.Http.Error Int) Int)


getLearnings : Cmd Msg
getLearnings =
    send GotLearnings (queryRequest graphqlServerUrl learningsQuery)


getLearningCount : Cmd Msg
getLearningCount =
    send GotLearningCount (queryRequest graphqlServerUrl learningCountQuery)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotLearnings result ->
            case result of
                Ok learnings ->
                    ( { model | learnings = learnings }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        GetLearningCount ->
            ( model, getLearningCount )

        GotLearningCount result ->
            case result of
                Ok learningCount ->
                    ( { model | learningCount = learningCount }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


viewLearnings : Model -> Html Msg
viewLearnings { learnings } =
    Html.dl [] <|
        List.concatMap viewLearning learnings


viewLearning : Learning -> List (Html Msg)
viewLearning learning =
    [ Html.dt [ onClick <| GetLearningCount ] [ Html.text <| learning.content ]
    , Html.dd [] (List.map Html.text learning.tags)
    ]


viewLearningCount : Model -> Html Msg
viewLearningCount { learningCount } =
    Html.div [] [ Html.text <| "learningCount: " ++ String.fromInt learningCount ]
