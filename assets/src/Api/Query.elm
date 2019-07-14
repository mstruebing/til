-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Query exposing (LearningsByTagRequiredArguments, LearningsByUserIdRequiredArguments, LearningsByUserRequiredArguments, learningCount, learnings, learningsByTag, learningsByUser, learningsByUserId, userCount, users)

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


learningCount : SelectionSet Int RootQuery
learningCount =
    Object.selectionForField "Int" "learningCount" [] Decode.int


learnings : SelectionSet decodesTo Api.Object.Learning -> SelectionSet (List decodesTo) RootQuery
learnings object_ =
    Object.selectionForCompositeField "learnings" [] object_ (identity >> Decode.list)


type alias LearningsByTagRequiredArguments =
    { tag : String }


learningsByTag : LearningsByTagRequiredArguments -> SelectionSet decodesTo Api.Object.Learning -> SelectionSet (List decodesTo) RootQuery
learningsByTag requiredArgs object_ =
    Object.selectionForCompositeField "learningsByTag" [ Argument.required "tag" requiredArgs.tag Encode.string ] object_ (identity >> Decode.list)


type alias LearningsByUserRequiredArguments =
    { handle : String }


learningsByUser : LearningsByUserRequiredArguments -> SelectionSet decodesTo Api.Object.Learning -> SelectionSet (List decodesTo) RootQuery
learningsByUser requiredArgs object_ =
    Object.selectionForCompositeField "learningsByUser" [ Argument.required "handle" requiredArgs.handle Encode.string ] object_ (identity >> Decode.list)


type alias LearningsByUserIdRequiredArguments =
    { userId : Api.ScalarCodecs.Id }


learningsByUserId : LearningsByUserIdRequiredArguments -> SelectionSet decodesTo Api.Object.Learning -> SelectionSet (List decodesTo) RootQuery
learningsByUserId requiredArgs object_ =
    Object.selectionForCompositeField "learningsByUserId" [ Argument.required "userId" requiredArgs.userId (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ] object_ (identity >> Decode.list)


userCount : SelectionSet Int RootQuery
userCount =
    Object.selectionForField "Int" "userCount" [] Decode.int


users : SelectionSet decodesTo Api.Object.User -> SelectionSet (List decodesTo) RootQuery
users object_ =
    Object.selectionForCompositeField "users" [] object_ (identity >> Decode.list)