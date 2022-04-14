module BrailleTranslator exposing (Model, Msg(..), defaultKey, init, main, translateText, update, view)

import Browser
import BrailleConverter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { currentText : String }


init : Model
init =
    { currentText = "" }


defaultKey : String
defaultKey =
    "😳"

linkToAph = 

  a [ href "https://www.aph.org/accessibility-solutions/" ] [ text "American Printing House" ] 

  

content link = 

  p [ ] 

    [ text "Send braille to " 

    , link 

    ] 

-- UPDATE


type Msg
    = SetCurrentText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ node "link"
            [ rel "stylesheet"
            , href "stylesheets/main.css"
            ]
            []
        , header
            []
            [ div
                [ class "nav-wrapper light-blue lighten-2" ]
                [ h1
                    [ class "brand-logo center" ]
                    [ text "Braille Translator" ]
                ]
            ]
        , section
            [ class "container" ]
            [ div
                [ class "input-field" ]
                [ input
                    [ type_ "text"
                    , class "center"
                    , placeholder "Translate Text To Braille"
                    , onInput SetCurrentText
                    ]
                    []
                ]
            , p
                [ class "center output-text emoji-size" ]
                [ text (translateText model) ]
            ]
            , footer
            []
            [ div
                [ class "content" ]
                    [ content linkToAph ]
            ]
        ]


translateText : Model -> String
translateText model =
    BrailleConverter.textToEmoji defaultKey model.currentText
