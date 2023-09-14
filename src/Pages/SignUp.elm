module Pages.SignUp exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Html.Events exposing (..)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { email : String
    , verifyEmail : String
    , password : String
    , verifyPassword : String
    , error : String
    , errorTitle : String
    }


init : () -> ( Model, Effect Msg )
init () =
    ( { email = ""
      , verifyEmail = ""
      , password = ""
      , verifyPassword = ""
      , error = ""
      , errorTitle = ""
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = EmailInput String
    | VerifyEmailInput String
    | PasswordInput String
    | VerifyPasswordInput String
    | Signup
    | SetErrorInvalid


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        EmailInput email ->
            ( { model | email = email }, Effect.none )

        VerifyEmailInput email ->
            ( { model | verifyEmail = email }, Effect.none )

        PasswordInput password ->
            ( { model | password = password }, Effect.none )

        VerifyPasswordInput password ->
            ( { model | verifyPassword = password }, Effect.none )

        Signup ->
            if model.email /= "" && model.verifyEmail /= "" && model.password /= "" && model.verifyPassword /= "" then
                if model.email /= model.verifyEmail then
                    ( { model | error = "Your Emails do not match", errorTitle = "Invalid Email" }, Effect.none )

                else if model.password /= model.verifyPassword then
                    ( { model | error = "Your Passwords do not match", errorTitle = "Invalid Password" }, Effect.none )

                else
                    -- TODO: add Signup logic here
                    ( { model | error = "", errorTitle = "", email = "", verifyEmail = "", password = "", verifyPassword = "" }, Effect.none )

            else
                ( { model | error = "Please enter all of the fields", errorTitle = "Incomplete Form" }, Effect.none )

        SetErrorInvalid ->
            ( { model | error = "Invalid email or password" }, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Sign Up"
    , body =
        [ div [ Attrs.class "h-full grid place-items-center" ]
            [ section [ class "max-w-4xl p-6 mx-auto bg-white rounded-md shadow-md dark:bg-gray-800" ]
                [ h2 [ class "text-lg font-semibold text-gray-700 capitalize dark:text-white" ] [ text "Sign Up" ]
                , Html.form [ onSubmit Signup ]
                    [ div [ class "grid grid-cols-1 gap-6 mt-4 sm:grid-cols-2" ]
                        [ div []
                            [ label [ class "text-gray-700 dark:text-gray-200", for "email" ] [ text "Email Address" ]
                            , input [ type_ "email", value model.email, onInput EmailInput, required True, attribute "autocomplete" "new-email", id "email", class "block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-200 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 focus:ring-blue-300 focus:ring-opacity-40 dark:focus:border-blue-300 focus:outline-none focus:ring" ] []
                            ]
                        , div []
                            [ label [ class "text-gray-700 dark:text-gray-200", for "confirm-email" ] [ text "Confirm email" ]
                            , input [ type_ "email", value model.verifyEmail, onInput VerifyEmailInput, required True, attribute "autocomplete" "new-email", id "confirm-email", class "block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-200 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 focus:ring-blue-300 focus:ring-opacity-40 dark:focus:border-blue-300 focus:outline-none focus:ring" ] []
                            ]
                        , div []
                            [ label [ class "text-gray-700 dark:text-gray-200", for "password" ] [ text "Password" ]
                            , input [ type_ "password", value model.password, onInput PasswordInput, required True, attribute "autocomplete" "new-password", id "password", class "block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-200 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 focus:ring-blue-300 focus:ring-opacity-40 dark:focus:border-blue-300 focus:outline-none focus:ring" ] []
                            ]
                        , div []
                            [ label [ class "text-gray-700 dark:text-gray-200", for "passwordConfirmation" ] [ text "Password Confirmation" ]
                            , input [ type_ "password", value model.verifyPassword, onInput VerifyPasswordInput, required True, attribute "autocomplete" "new-password", id "passwordConfirmation", class "block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-200 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 focus:ring-blue-300 focus:ring-opacity-40 dark:focus:border-blue-300 focus:outline-none focus:ring" ] []
                            ]
                        ]
                    , div [ class "flex justify-end mt-6" ]
                        [ button [ type_ "submit", class "px-8 py-2.5 leading-5 text-white transition-colors duration-300 transform bg-gray-700 rounded-md hover:bg-gray-600 focus:outline-none focus:bg-gray-600" ] [ text "Sign Up" ]
                        ]
                    , div []
                        [ a
                            [ href "/login"
                            , class "text-gray-600 dark:text-gray-200 hover:underline"
                            ]
                            [ text "Go To Login" ]
                        ]
                    ]
                , if model.error /= "" then
                    div [ class "grid place-items-center" ]
                        [ div
                            [ id "error"
                            , class "flex w-full max-w-sm overflow-hidden bg-white rounded-lg shadow-md dark:bg-gray-800"
                            ]
                            [ div [ class "grid place-items-center w-12 bg-red-500" ]
                                [ span [ class "material-icons" ] [ text "priority_high" ]
                                ]
                            , div
                                [ class "px-4 py-2 -mx-3" ]
                                [ div
                                    [ class "mx-3"
                                    ]
                                    [ span
                                        [ class "font-semibold text-red-500 dark:text-red-400"
                                        ]
                                        [ text model.errorTitle ]
                                    , p
                                        [ class "text-sm text-gray-600 dark:text-gray-200"
                                        ]
                                        [ text model.error ]
                                    ]
                                ]
                            ]
                        ]

                  else
                    div [] []
                ]
            ]
        ]
    }