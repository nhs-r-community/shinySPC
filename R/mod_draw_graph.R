#' draw_graph UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_draw_graph_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' draw_graph Server Functions
#'
#' @noRd 
mod_draw_graph_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
