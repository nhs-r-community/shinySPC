#' data_load UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_data_load_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 4,
        datamods::import_file_ui(ns("myid"))
      ),
      column(
        width = 8,
        tags$b("Imported data:"),
        DT::DTOutput(ns("show_data"))
      )
    )
  )
}

#' data_load Server Functions
#'
#' @noRd 
mod_data_load_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    imported <- datamods::import_file_server("myid")
    
    output$show_data <- DT::renderDT({
      imported$data()
    })
    
    reactive(
      imported$data()
    )
  })
}
