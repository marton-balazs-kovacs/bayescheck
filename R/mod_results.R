#' results UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_results_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Iteratively show statistics
    uiOutput(NS(id, "paper_ui")),
  )
}

#' results Server Functions
#'
#' @noRd
mod_results_server <- function(id, input_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Select the data for papers
    paper_data <- reactive({
      input_data() %>%
        dplyr::group_by(Source) %>%
        dplyr::mutate(paper_index = dplyr::cur_group_id()) %>%
        dplyr::group_by(paper_index) %>%
        tidyr::nest()

    })

    # Render paper ui iteratively
    output$paper_ui <- renderUI({
      purrr::map(paper_data()$paper_index,
                 ~ mod_paper_ui(ns(paste0("paper", .x))))
    })

    # Create the paper server iteratively
    observe({
      purrr::map2(paper_data()$paper_index, paper_data()$data,
                  ~ mod_paper_server(paste0("paper", .x), input_data = .y))
    })
  })
}

## To be copied in the UI
# mod_results_ui("results")

## To be copied in the server
# mod_results_server("results")
