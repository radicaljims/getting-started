import Html.App as App

import Model exposing (init, update, Mdl)
import View  exposing (view)

import Material

main : Program Never
main =
  App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = \model -> Material.subscriptions Mdl model
    }
