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
        actionButton(ns("launch_modal"), "Upload new data"),
        uiOutput(ns("format_checkbox")),
        uiOutput(ns("date_picker")),
      ),
      column(
        width = 8,
        h2("Imported data:"),
        h3("Note that the date is being correctly read if it displays in the 
           table as YYYY-MM-DD"),
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
    
    observeEvent(input$launch_modal, {
      datamods::import_modal(
        id = session$ns("myid"),
        from = "file",
        title = "Import data to be used in application"
      )
    })
    
    imported <- datamods::import_server("myid", return_class = "tbl_df")
    
    final_data <- reactive({
      
      req(imported$data())
      
      return_data <- imported$data()
      
      if(input$format_date){
        
        if(typeof(return_data[[input$date_field]]) == "character"){

          return_data <- return_data %>% 
            dplyr::mutate(across(all_of(input$date_field),
                                 ~ as.Date(., format = input$data_format)))
        }
      }
      
      return(return_data)
    })
    
    output$show_data <- DT::renderDT({
      
      req(final_data())
      
      final_data()
    })
    
    output$format_checkbox <- renderUI({
      
      req(imported$data())
      
      checkboxInput(session$ns("format_date"), "Format date?")
    })
    
    output$date_picker <- renderUI({
      
      req(imported$data())
      
      if(!input$format_date){
        
        return()
      }
      
      tagList(
        selectInput(session$ns("data_format"), "Date format",
                    choices = c("DD-MM-YYYY" = "%d-%m-%Y", 
                                "MM-DD-YYYY" = "%m-%d-%Y",
                                "YYYY-MM-DD" = "%Y-%m-%d",
                                "DD/MM/YYYY" = "%d/%m/%Y", 
                                "MM/DD/YYYY" = "%m/%d/%Y",
                                "YYYY/MM/DD" = "%Y/%m/%d")
        ),
        selectInput(session$ns("date_field"), "Date column", 
                    choices = names(imported$data()))
      )
    })
    
    reactive(
      final_data()
    )
  })
}
