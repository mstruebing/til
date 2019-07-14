-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.ScalarCodecs exposing (Id, NaiveDateTime, codecs)

import Api.Scalar exposing (defaultCodecs)
import Json.Decode as Decode exposing (Decoder)


type alias Id =
    Api.Scalar.Id


type alias NaiveDateTime =
    Api.Scalar.NaiveDateTime


codecs : Api.Scalar.Codecs Id NaiveDateTime
codecs =
    Api.Scalar.defineCodecs
        { codecId = defaultCodecs.codecId
        , codecNaiveDateTime = defaultCodecs.codecNaiveDateTime
        }
