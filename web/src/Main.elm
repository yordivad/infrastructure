module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Material.Button exposing (buttonConfig, textButton)

main = Browser.sandbox{init=0, update = update, view = view}

type Msg = Incr | Decr

update msg model =
  case msg of
    Incr -> model + 1
    Decr -> model - 1

view model =
  div []
    [button [ onClick Incr] [ text "+" ]
    , div [] [text (String.fromInt model) ]
    , textButton { buttonConfig | icon = Just "favorite" | onClick = Just Decr} "decr"
    ]
