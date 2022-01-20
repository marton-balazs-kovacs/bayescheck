#' read_paper UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_read_paper_ui <- function(id){
  tagList(
    h5("Choose one or more pdf, html, or docx article on your computer and click the upload button"),
    fileInput(
      NS(id, "file"),
      label = NULL,
      accept = c(
        '.pdf',
        '.hmtl',
        '.docx'),
      multiple = TRUE)
  )
}

#' read_paper Server Functions
#'
#' @noRd
mod_read_paper_server <- function(id){
  # File uploading limit: 9MB
  options(shiny.maxRequestSize = 9*1024^2)

  moduleServer( id, function(input, output, session){
    ns <- session$ns

    statcheck_res <- reactive({
      # Require input to run
      req(input$file)
      # Get extensions for validation
      ext <- tools::file_ext(input$file$datapath)
      # Get temp dir path for uploaded files
      dir_path <- unique(sub("[^/]+$", "", input$file$datapath))
      # Run statcheck
      res <- statcheck::checkdir(dir_path)
      # TODO: Replace Source names as shiny uses numeric placeholders on input files
      # temp_filename <- gsub(".*[/]([^.]+)[.].*", "\\1", input$file$datapath)
      # Return output
      return(res)
    })

    output$test2 <- renderText({
      gsub(".*[/]([^.]+)[.].*", "\\1", input$file$datapath)
    })

    return(
      list(
        statcheck_res = statcheck_res
      )
    )
  })
}

## To be copied in the UI
# mod_read_paper_ui("read_paper")

## To be copied in the server
# mod_read_paper_server("read_paper")
