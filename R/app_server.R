#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  ## translations
  translator <- ExampleMultilingualShiny::i18n

  i18n_r <- reactive({
    selected <- input$selected_language
    if (length(selected) > 0 && selected %in% translator$get_languages()) {
      translator$set_translation_language(selected)
    }
    return(translator)
  })

  output$language_selector <- renderUI({
    shiny::div(id= "shiny_language_selector",
               style="width: 70px; ",
               selectInput('selected_language',
                           label = NULL,
                           multiple = FALSE,
                           choices = translator$get_languages(),
                           selected = input$selected_language)
               )
    })

  ## Main UI


  output$page_content <- renderUI({
    bs4Dash::dashboardPage(
      title = "Basic Shiny app with multilingual workflow",
      header = bs4Dash::dashboardHeader(rightUi = tagList(uiOutput("language_selector"))),
      sidebar = bs4Dash::dashboardSidebar(
        collapsed = FALSE, minified = FALSE,
        bs4Dash::sidebarMenu(
          id = "sidebarmenu",
          bs4Dash::sidebarHeader("Menu"),
          bs4Dash::menuItem(
            tabName = "tab_home",
            # text = translator$t("Homepage") # not working
            # text = i18n_r()$t("Homepage") # not working
            text = "Home"
            )
          )
        ),
      controlbar = bs4Dash::dashboardControlbar(),
      footer = bs4Dash::dashboardFooter(),
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "tab_home",
            mod_Homepage_ui("Homepage_1")
          )
        )
      )
    )
  })


  ## Modules

  mod_Homepage_server("Homepage_1", i18n_r)

}
