#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Read paper and run statcheck
  read_out <- mod_read_paper_server("read_paper")

  # Render results
  mod_results_server("results", input_data = read_out$statcheck_res)
}
