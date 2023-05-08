#' Homepage UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_Homepage_ui <- function(id){
  ns <- NS(id)
  tagList(

    uiOutput(ns("test"))

  )
}

#' Homepage Server Functions
#'
#' @noRd
mod_Homepage_server <- function(id, i18n_r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$test <- renderUI({
      fluidRow(
        shiny::div(
          shiny::h1(i18n_r()$t("This is a title")),
          shiny::br(),
          shiny::h2(i18n_r()$t("Home"))
          )
        )
    })
  })
}

## To be copied in the UI
# mod_Homepage_ui("Homepage_1")

## To be copied in the server
# mod_Homepage_server("Homepage_1")
