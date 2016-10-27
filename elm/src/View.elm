module View exposing (..)

import Model exposing (Mdl, Msg, Model, Friend)

import Html exposing (..)
import Html.Attributes exposing (style)

import Material.Color as Color
import Material.Layout as Layout
import Material.List as Lists
import Material.Scheme
import Material.Toggles as Toggles

import List exposing (indexedMap)
import Set exposing (Set)

-- This view function sets up the overall rendering of the whole page
-- It wraps up smaller functions that handle the individual parts: a header, the body, and the friends lis
view : Model -> Html Msg
view model =
  Layout.render Mdl
    model.mdl
      [ Layout.waterfall True
      , Layout.fixedHeader
      , Layout.rippleTabs
      ]
      { header = [ header ]
      , drawer = []
      , tabs = ( [text "Friends"], [] )
      , main = [body model]
      }

    -- This here is boilerplate to load in the Material JS resources and setup the color scheme
    -- Go here to read about what '|>' means (it's a kind of function application):
    -- http://elm-lang.org/docs/syntax
    |> Material.Scheme.topWithScheme Color.BlueGrey Color.Indigo

header : Html Msg
header =
  div
    []
    [h3 [style [("padding", "10px")]] [text "Friends!"]]

body : Model -> Html Msg
body model =
  div
    [] -- no CSS bits for now, but this where you'd put them if you had them
    [friendList model]

friendList : Model -> Html Msg
friendList model =
  let
    create = createItem model
  in
    Lists.ul
      [] -- no CSS bits for now, but this where you'd put them if you had them
      (indexedMap create model.friends)

createItem : Model -> Int -> Friend -> Html Msg
createItem model idx friend =
  Lists.li
    [ Lists.withSubtitle ]
    [ Lists.content
        []
        [ Lists.avatarIcon
          "sentiment_very_satisfied" [] -- TODO: give this icon a color!
        , text friend.name
        , Lists.subtitle [] [ text friend.nickname ]
        ]
      -- TODO: pop up a 'Remove Friend' button when a checkbox is selected?
      -- Aside from the HTML we'd have to add somewhere, we'd also need a 'RemoveFriends'
      -- message in the model for the button to generate
    , Lists.content2
        []
        -- elm-mdl has us specify a unique identifier for stateful things like toggle buttons,
        -- hence the use of indexedMap above so we have an idx to use here
        -- (it's also obviously useful for us as well)
        [ Toggles.checkbox Mdl [idx] model.mdl
            [ Toggles.value (Set.member idx model.removes)
            , Toggles.onClick (Model.ToggleRemoveFriend idx)
            ]
            []
        ]
    ]
