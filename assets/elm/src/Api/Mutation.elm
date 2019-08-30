-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Mutation exposing (CreateLearningOptionalArguments, CreateLearningRequiredArguments, CreateUserRequiredArguments, LoginRequiredArguments, createLearning, createUser, login, logout)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


type alias CreateLearningOptionalArguments =
    { private : OptionalArgument Bool }


type alias CreateLearningRequiredArguments =
    { content : String
    , tags : List String
    , title : String
    }


createLearning : (CreateLearningOptionalArguments -> CreateLearningOptionalArguments) -> CreateLearningRequiredArguments -> SelectionSet decodesTo Api.Object.Learning -> SelectionSet (Maybe decodesTo) RootMutation
createLearning fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { private = Absent }

        optionalArgs =
            [ Argument.optional "private" filledInOptionals.private Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "createLearning" (optionalArgs ++ [ Argument.required "content" requiredArgs.content Encode.string, Argument.required "tags" requiredArgs.tags (Encode.string |> Encode.list), Argument.required "title" requiredArgs.title Encode.string ]) object_ (identity >> Decode.nullable)


type alias CreateUserRequiredArguments =
    { email : String
    , handle : String
    , password : String
    }


createUser : CreateUserRequiredArguments -> SelectionSet decodesTo Api.Object.User -> SelectionSet (Maybe decodesTo) RootMutation
createUser requiredArgs object_ =
    Object.selectionForCompositeField "createUser" [ Argument.required "email" requiredArgs.email Encode.string, Argument.required "handle" requiredArgs.handle Encode.string, Argument.required "password" requiredArgs.password Encode.string ] object_ (identity >> Decode.nullable)


type alias LoginRequiredArguments =
    { email : String
    , password : String
    }


login : LoginRequiredArguments -> SelectionSet decodesTo Api.Object.Session -> SelectionSet (Maybe decodesTo) RootMutation
login requiredArgs object_ =
    Object.selectionForCompositeField "login" [ Argument.required "email" requiredArgs.email Encode.string, Argument.required "password" requiredArgs.password Encode.string ] object_ (identity >> Decode.nullable)


logout : SelectionSet decodesTo Api.Object.User -> SelectionSet (Maybe decodesTo) RootMutation
logout object_ =
    Object.selectionForCompositeField "logout" [] object_ (identity >> Decode.nullable)
