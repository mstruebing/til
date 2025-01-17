-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.Learning exposing (author, content, id, insertedAt, tags, title, updatedAt, userId)

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
import Json.Decode as Decode


author : SelectionSet String Api.Object.Learning
author =
    Object.selectionForField "String" "author" [] Decode.string


content : SelectionSet String Api.Object.Learning
content =
    Object.selectionForField "String" "content" [] Decode.string


id : SelectionSet Api.ScalarCodecs.Id Api.Object.Learning
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecId |> .decoder)


insertedAt : SelectionSet (Maybe Api.ScalarCodecs.NaiveDateTime) Api.Object.Learning
insertedAt =
    Object.selectionForField "(Maybe ScalarCodecs.NaiveDateTime)" "insertedAt" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecNaiveDateTime |> .decoder |> Decode.nullable)


tags : SelectionSet (List String) Api.Object.Learning
tags =
    Object.selectionForField "(List String)" "tags" [] (Decode.string |> Decode.list)


title : SelectionSet String Api.Object.Learning
title =
    Object.selectionForField "String" "title" [] Decode.string


updatedAt : SelectionSet (Maybe Api.ScalarCodecs.NaiveDateTime) Api.Object.Learning
updatedAt =
    Object.selectionForField "(Maybe ScalarCodecs.NaiveDateTime)" "updatedAt" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecNaiveDateTime |> .decoder |> Decode.nullable)


userId : SelectionSet String Api.Object.Learning
userId =
    Object.selectionForField "String" "userId" [] Decode.string
