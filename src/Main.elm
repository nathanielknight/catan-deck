module Main exposing (main)

import Browser
import Html
import Html.Attributes
import Html.Events exposing (onClick)
import Random
import Random.List


type alias Card =
    Int



-- { number : Int
-- , title : String
-- , text : String
-- }


type alias Model =
    { deck : List Card
    , discard : List Card
    }


type Msg
    = Draw
    | Shuffle
    | Shuffled (List Card)


shuffleDeck =
    Random.generate Shuffled (Random.List.shuffle rawCards)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Draw ->
            ( drawCard model, Cmd.none )

        Shuffle ->
            ( model, shuffleDeck )

        Shuffled deck ->
            ( { deck = deck, discard = [] }, Cmd.none )


drawCard model =
    case model.deck of
        [] ->
            model

        x :: xs ->
            { model | deck = xs, discard = x :: model.discard }



--------------------------------------------------------------------


view : Model -> Html.Html Msg
view m =
    Html.div []
        [ Html.text <| Debug.toString m.deck
        , Html.text <| Debug.toString m.discard
        , Html.button [ onClick Draw ] [ Html.text "Draw" ]
        , Html.button [ onClick Shuffle ] [ Html.text "Shuffle" ]
        ]



--------------------------------------------------------------------


rawCards =
    [ 1, 2, 3, 4, 5, 6 ]


init : () -> (Model, Cmd Msg)
init () =
    ( { deck = rawCards
      , discard = []
      }
    , Cmd.none
    )


subscriptions _ =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
