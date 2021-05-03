#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  data_load <- mod_data_load_server("data_load_ui_1")
  
  mod_draw_graph_server("draw_graph_ui_1", data = data_load)
  
}
