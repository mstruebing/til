module Auth exposing (Model, Msg(..), init, login, loginForm, loginMutation, loginSelection, update)

import Api.Mutation as Mutation
import Api.Object
import Api.Object.Session as Session
import Graphql.Http exposing (mutationRequest, send)
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (Html)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onClick, onInput, onSubmit)
import Shared exposing (graphqlServerUrl)


type alias Model =
    { token : String
    , password : String
    , email : String
    , handle : String
    }


type Msg
    = Login
    | LoggedIn (Result (Graphql.Http.Error (Maybe String)) (Maybe String))
    | UpdateUsername String
    | UpdatePassword String


emptyModel : Model
emptyModel =
    { token = ""
    , password = ""
    , email = ""
    , handle = ""
    }


init : ( Model, Cmd Msg )
init =
    ( emptyModel
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Login ->
            ( model, login model )

        LoggedIn (Ok (Just token)) ->
            ( { model | token = token }, Cmd.none )

        LoggedIn (Ok Nothing) ->
            ( model, Cmd.none )

        LoggedIn (Err _) ->
            ( model, Cmd.none )

        UpdateUsername username ->
            ( { model | email = username }, Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Cmd.none )


login : Model -> Cmd Msg
login model =
    loginMutation model
        |> mutationRequest graphqlServerUrl
        |> send LoggedIn


loginMutation : Model -> SelectionSet (Maybe String) RootMutation
loginMutation { email, password } =
    Mutation.login { email = email, password = password } loginSelection


loginSelection : SelectionSet String Api.Object.Session
loginSelection =
    SelectionSet.map
        (\maybeToken ->
            case maybeToken of
                Just token ->
                    token

                Nothing ->
                    ""
        )
        Session.token


loginForm : Html Msg
loginForm =
    Html.form [ onSubmit Login ]
        [ Html.input [ onInput UpdateUsername, placeholder "email" ] []
        , Html.input [ onInput UpdatePassword, placeholder "password" ] []
        , Html.button [ onClick Login ] [ Html.text "Login" ]
        ]
