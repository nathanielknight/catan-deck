module Main exposing (main)

import Browser
import Html exposing (button, div, p, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Random
import Random.List


type alias Card =
    { number : Int
    , title : String
    , text : String
    }


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
    Html.div [ class "app" ]
        [ drawctrl m
        , cardframe m
        ]


topcard : Model -> Maybe Card
topcard m =
    case m.deck of
        [] ->
            Nothing

        c :: _ ->
            Just c


drawctrl m =
    let
        n =
            String.fromInt <| List.length m.deck
    in
    div []
        [ p [] [ text <| "(" ++ n ++ " left)" ]
        , button [ onClick Draw ] [ text "Draw" ]
        ]


cardframe : Model -> Html.Html Msg
cardframe m =
    let
        c =
            topcard m

        classes =
            case c of
                Nothing ->
                    "card empty"

                Just _ ->
                    "card"
    in
    Html.div [ id classes ] <| rendercard c


rendercard : Maybe Card -> List (Html.Html Msg)
rendercard mc =
    case mc of
        Nothing ->
            [ Html.button [ onClick Shuffle ] [ text "Shuffle" ] ]

        Just c ->
            [ Html.h1 [] [ text c.title ]
            , Html.h2 [] [ text <| String.fromInt c.number ]
            , Html.p [] [ text c.text ]
            ]



--------------------------------------------------------------------


init : () -> ( Model, Cmd Msg )
init () =
    ( { deck = rawCards
      , discard = []
      }
    , shuffleDeck
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


rawCards : List Card
rawCards =
    [ { number = 2, title = "Fallow", text = "" }
    , { number = 3, title = "Late Thaw", text = "" }
    , { number = 3, title = "Early Frost", text = "" }
    , { number = 4, title = "Friendly Sheep", text = "" }
    , { number = 4, title = "Stinky Sheep", text = "" }
    , { number = 4, title = "Mouldy Sheep", text = "" }
    , { number = 5, title = "Settler of the Week!", text = "" }
    , { number = 5, title = "Good Harvest", text = "" }
    , { number = 5, title = "Hard Work", text = "" }
    , { number = 5, title = "Best Laid Plans", text = "" }
    , { number = 6, title = "Abundance", text = "" }
    , { number = 6, title = "Building Materials", text = "All players gain one wood OR one brick." }
    , { number = 6, title = "Slow and Steady", text = "" }
    , { number = 6, title = "Immigration", text = "" }
    , { number = 6, title = "Stocking Up", text = "" }
    , { number = 7, title = "Foreign Aid", text = "The player with the lowest score gains two different resource cards of their choice. If more than one player has the lowest score, instead they each gain one resource card of their choice." }
    , { number = 7, title = "Free Trade", text = "Each player may immediately trade a set of three identical resource cards for a resource card of their choice, even if they don't have a 3-to-1 port." }
    , { number = 7, title = "High Demand", text = "Each player may immediately trade ANY four resource cards for a resource card of their choice." }
    , { number = 7, title = "Law and Order", text = "Move the robber back to the desert. Instead of stealing from another player, the player who drew this card gains one resource of their choice." }
    , { number = 7, title = "Strategic Planning", text = "Players with more than seven cards in their do not discard cards." }
    , { number = 7, title = "Farmer's Almanac", text = "Instead of moving the robber, the player who drew this card draws three development cards and chooses one to keep, placing the other two on the bottom of the deck." }
    , { number = 8, title = "Plenty", text = "" }
    , { number = 8, title = "Rampant Growth", text = "" }
    , { number = 8, title = "Full Granaries", text = "Each player gains one wheat OR one sheep." }
    , { number = 8, title = "Plenitude", text = "" }
    , { number = 8, title = "Prosperity", text = "" }
    , { number = 9, title = "Catan Day", text = "" }
    , { number = 9, title = "Pioneering", text = "" }
    , { number = 9, title = "Discovery", text = "" }
    , { number = 9, title = "At Long Last", text = "" }
    , { number = 10, title = "Festival ", text = "" }
    , { number = 10, title = "Overindulgence", text = "" }
    , { number = 10, title = "Recuperation", text = "" }
    , { number = 11, title = "Foreign Taxes", text = "" }
    , { number = 11, title = "Bad Storms", text = "" }
    , { number = 12, title = "Trade Emissary", text = "Each player may immediately trade one of any resource for one ore." }
    ]
