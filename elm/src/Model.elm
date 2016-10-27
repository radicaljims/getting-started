module Model exposing (..)

import Set exposing (Set)

import Material

type alias Friend = { name : String, nickname : String }

-- The Material lib has it's own model to track internal state like, "Is this button rippling?"
--
type alias Model = { friends : List Friend, removes : Set Int, mdl : Material.Model }

-- Our initial set of Friends and initial Material model
init : (Model, Cmd a)
init = { friends = [ { name = "Anthony", nickname = "Lil' Antny" }
                   , { name = "SteveM",  nickname = "Mohlsy" }
                   , { name = "Ping",    nickname = "Pingping" }
                   , { name = "Tomasz",  nickname = "Toemash" }
                   , { name = "SteveB",  nickname = "John" }
                   , { name = "Laura",   nickname = "Lil' Rip" } ]
       , removes = Set.empty
       , mdl = Material.model }
       ! []

type Msg =
      NoOp
    | ToggleRemoveFriend Int
    | Mdl (Material.Msg Msg)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    -- We don't do anything for NoOps
    NoOp -> model ! []

    -- TODO: implement this!
    ToggleRemoveFriend idx -> model ! []

    -- Let Material handle it's own messages
    Mdl msg' -> Material.update msg' model

type alias Mdl = Material.Model
