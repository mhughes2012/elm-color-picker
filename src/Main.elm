port module Main exposing (main)

import Browser
import ColorOption exposing (ColorOption)
import Constants exposing (imageSize, placeholderBaseUrl)
import Html exposing (Html, button, div, h2, h3, img, p, text)
import Html.Attributes exposing (alt, class, classList, src, style, title)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Product exposing (Product)
import String exposing (fromFloat, fromInt)


port outgoingPort : String -> Cmd msg


port incomingPort : (String -> msg) -> Sub msg


type alias UIState =
    { isHovered : Bool
    , selectedColorIndex : Int
    }


type alias Model =
    { product : Product
    , ui : UIState
    }


init : Model
init =
    { product =
        { title = "Flip Case"
        , price = 59.0
        , colors = Product.initialColors
        , images = Product.initialImages
        , description = "Slim protection for your everyday carry"
        }
    , ui =
        { isHovered = False
        , selectedColorIndex = 0
        }
    }


type Msg
    = MouseEnter
    | MouseLeave
    | SelectColor Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        MouseEnter ->
            { model
                | ui =
                    { isHovered = True
                    , selectedColorIndex = model.ui.selectedColorIndex
                    }
            }

        MouseLeave ->
            { model
                | ui =
                    { isHovered = False
                    , selectedColorIndex = model.ui.selectedColorIndex
                    }
            }

        SelectColor index ->
            { model
                | ui =
                    { isHovered = model.ui.isHovered
                    , selectedColorIndex = index
                    }
            }


getSelectedImage : Model -> String
getSelectedImage model =
    List.drop model.ui.selectedColorIndex model.product.images
        |> List.head
        |> Maybe.withDefault (makeImageUrl "000000")


makeImageUrl : String -> String
makeImageUrl colorCode =
    "https://" ++ placeholderBaseUrl ++ "/" ++ String.fromInt imageSize ++ "x" ++ String.fromInt imageSize ++ "/" ++ colorCode ++ "/" ++ colorCode


view : Model -> Html Msg
view model =
    div [ class "product-card" ]
        [ viewImage model
        , viewDetails model
        ]


viewImage : Model -> Html Msg
viewImage model =
    div
        [ class "product-image"
        , onMouseEnter MouseEnter
        , onMouseLeave MouseLeave
        ]
        [ img [ src (getSelectedImage model) ] [] ]


viewDetails : Model -> Html Msg
viewDetails model =
    div [ class "product-details" ]
        [ h2 [] [ text model.product.title ]
        , p [ class "price" ] [ text ("$" ++ String.fromFloat model.product.price) ]
        , viewColorOptions model
        , p [ class "description" ] [ text model.product.description ]
        ]


viewColorOptions : Model -> Html Msg
viewColorOptions model =
    div [ class "product-card__colors" ]
        (List.indexedMap (viewColorOption model) model.product.colors)


viewColorOption : Model -> Int -> ColorOption -> Html Msg
viewColorOption model index color =
    let
        isSelected =
            index == model.ui.selectedColorIndex
    in
    button
        [ onClick (SelectColor index)
        , class "product-card__color-button"
        , classList [ ( "selected", isSelected ) ]
        , style "background-color" color.hexCode
        ]
        []


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
