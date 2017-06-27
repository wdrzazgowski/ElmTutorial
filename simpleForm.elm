import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main = 
    Html.beginnerProgram { model = model, view = view, update = update }


--MODEL
type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }

model : Model
model = 
    Model "" "" ""



--UPDATE
type Msg
    = Name String
    | Password String
    | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password pwd ->
            { model | password = pwd }

        PasswordAgain pwdAgain ->
            { model | passwordAgain = pwdAgain }

--VIEW
view : Model -> Html Msg
view model = 
    div []
    [ input [type_ "text", placeholder "Name", onInput Name ] []
    , input [type_ "password", placeholder "Password", onInput Password ] []
    , input [type_ "password", placeholder "Re-Enter Password", onInput PasswordAgain ] []
    , viewValidation model
    , passwordLengthValidation model
    ]

viewValidation : Model -> Html Msg
viewValidation model = 
    let
        (color, message) = 
            if model.password == model.passwordAgain then 
                ("green", "Password match")
            else
                ("red", "Passwords do not match!")
    in
        div [ style [("color", color)] ] [text message ]

passwordLengthValidation : Model -> Html Msg
passwordLengthValidation model =
    let 
        (color, message) = 
            if String.length model.password > 8 then
                ("green", "Password long enough!")
            else
                ("red", "Password must be over 8 character long.")
    in
        div [ style [("color", color)] ] [ text message ]
