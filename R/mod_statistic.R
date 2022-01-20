#' statistic UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_statistic_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Title
    h3(textOutput(NS(id, "statistic_title"))),
    # Text of the extracted statistic
    textOutput(NS(id, "statistic_text")),
    # Show Bayes factor
    textOutput(NS(id, "bf_text")),
    # Show robustness switch
    shinyWidgets::materialSwitch(NS(id, "robustness_switch"), label = "Robustness", value = TRUE),
    # Show robustness plot
    plotly::plotlyOutput(NS(id, "robustness_plot")),
    # Select if it is a one-tailed test or not
    shinyWidgets::materialSwitch(NS(id, "one_tailed_switch"), label = "One tail", value = TRUE),
    # Set alpha (defaults to 0.05)
    sliderInput(NS(id, "alpha"), "alpha", min = 0, max = 1, value = 0.05, step = 0.05),
    # Direction of the test
    selectInput(NS(id, "test_direction"), "Direction", choices = c("equal", "greater", "smaller")),
    # Select Cauchy prior
    selectInput(NS(id, "prior"), "Prior", choices = c("default", "wide", "ultrawide"))
    )
}

#' statistic Server Functions
#'
#' @noRd
mod_statistic_server <- function(id, input_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # Title
    output$statistic_title <- renderText({
      switch(input_data$Statistic,
             "t" = "t value",
             "cor" = "Correlation",
             "F" = "F value",
             "chisq" = "Chi-square value",
             "Z" = "Z value",
             "Q" = "Q value")
    })
    # Raw reported test statistic
    output$statistic_text <- renderText({
      input_data$Raw
    })
    # Calculating the Bayes factor
    output$bf_text <- renderText({

    })
  })
}

## To be copied in the UI
# mod_statistic_ui("statistic")

## To be copied in the server
# mod_statistic_server("statistic")
