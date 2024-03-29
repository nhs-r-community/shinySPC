#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    ui <- dashboardPage(
      dashboardHeader(title = "Shiny SPC"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Data load", tabName = "data_load", icon = icon("file-upload")),
          menuItem("Graph", tabName = "graph", icon = icon("chart-line"))
        )
      ),
      dashboardBody(
        tabItems(
          # First tab content
          tabItem(tabName = "data_load",
                  mod_data_load_ui("data_load_ui_1")
                  ),
          
          # Second tab content
          tabItem(tabName = "graph",
                  mod_draw_graph_ui("draw_graph_ui_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(ext = 'png'),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinySPC'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

