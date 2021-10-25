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
    uiOutput(ns("axisSelection")),
    plotOutput(ns("showData"))
  )
}
    
#' draw_graph Server Functions
#'
#' @noRd 
mod_draw_graph_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$axisSelection <- renderUI({
      
      tagList(
        fluidRow(
          column(2, 
                 selectInput(ns("xAxis"), "X- axis", choices = names(data()),
                             selected = names(data())[1])),
          column(2, 
                 selectInput(ns("yAxis"), "Y- axis", choices = names(data()),
                             selected = names(data())[2]))
        )
      )
    })
    
    # look at column selection -> to THREE columns- time, measure, and small multiple
    
    output$showData <- renderPlot({
      
      df <- data() %>% 
        dplyr::select(input$xAxis, input$yAxis)
      
      names(df) <- c("Time", "Value")
      
      # df %>%
      #   qicharts2::qic(Time, Value,
      #                  data     = .)
      
      df %>%
        dplyr::mutate(Value = as.numeric(Value)) %>% 
        NHSRplotthedots::ptd_spc(value_field = Value, date_field = Time)
    })
 
  })
}
