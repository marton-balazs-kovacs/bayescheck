#' paper UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_paper_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Title
    h2(textOutput(NS(id, "paper_title"))),
    # Iteratively show statistics
    uiOutput(NS(id, "statistic_ui"))
  )
}

#' paper Server Functions
#'
#' @noRd
mod_paper_server <- function(id, input_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # Title
    output$paper_title <- renderText({
      unique(input_data$Source)
    })

    # Select data for statistics
    statistic_data <- reactive({
      input_data %>%
        dplyr::mutate(statistic_index = 1:nrow(.)) %>%
        dplyr::group_by(statistic_index) %>%
        tidyr::nest()
    })

    # Iteratively render statistics UI
    output$statistic_ui <- renderUI({
      purrr::map(statistic_data()$statistic_index,
                 ~ mod_statistic_ui(ns(paste0("statistic", .x))))
    })

    # Create the statistic server iteratively
    observe({
      purrr::map2(statistic_data()$statistic_index, statistic_data()$data,
                  ~ mod_statistic_server(paste0("statistic", .x), input_data = .y))
    })
  })
}

## To be copied in the UI
# mod_paper_ui("paper")

## To be copied in the server
# mod_paper_server("paper")
