module Tests exposing (..)

import Test exposing (..)
import Expect
--import Fuzz exposing (list, int, tuple, string)
import Result exposing (withDefault)
import Types exposing (..)
import GeoJSON exposing (..)
import Geometry exposing (..)
import Array exposing (fromList)
import Json.Decode exposing (decodeString)
import Debug
import String



all : Test
all =
    describe "Sample Test Suite"
        [ describe "GeoJSON Tests"
            [ test "Point" <| 
                \() -> 
                    let s = "{\"type\": \"Point\",\"coordinates\": [100.0, 0.0] }"
                        result = decodeString decodeGeometry s
                        expect = Geometry_Point <| Point {x=100.0, y=0}
                        default = Geometry_Point <| Point {x=0,y=0}
                    in Expect.equal (withDefault default result) expect
            ]
        , describe "Geometry Tests"
          [ test "Envelope" <| 
              \() -> 
                  let ls = LineString <| fromList [ {x=0,y=0}, {x=3,y=-2}, {x=2, y=0} ]
                      result = lineStringToEnvelope ls
                      expect = { min = { x = 0, y = -2 }, max = { x = 3, y = 0 } }
                  in Expect.equal result expect
          ]
        ]
