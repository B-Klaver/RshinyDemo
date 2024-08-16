#' @title Run the shiny app
#' @name MyApp
#' @rdname MyApp
#' @export MyApp
#' @aliases MyApp
#' @description  MyApp() will load all assets and
#' run the shiny app.
#' @usage MyApp()
#' @return Starts up the shiny app

MyApp <- function() {
  
  
  ### Load the CD data -----------------------------------------------
  
  example_data <- readRDS(
    system.file("ext", "example_data.RDS",
                package = "RshinyDemo")
  )
  
  ### add paths for app to see within the www folder
  ### because the header requires these folders to render
  #shiny::addResourcePath("css", file.path(getwd(), "www/css"))
  #shiny::addResourcePath("images", file.path(getwd(), "www/images"))
  
  
  ### Prepare the UI --------------------------------------------------
  ui <- htmltools::tagList(
    
    bslib::page_navbar(
      
      id = "nav",
      
      #title = "Communicable Disease Dashboard",
      title = htmltools::HTML("My App"),
      
      bg = "#004987",
      
      underline = TRUE,
      
      window_title = "My App",
      
      fillable_mobile = TRUE,
      
      ## bslib version ---------------------------------------------------
      
      theme = bslib::bs_theme(version = 5),
      
      ## nav_panel 2 -----------------------------------------------------
      
      bslib::nav_panel(
        
        title = "Trend",
        
        bslib::layout_column_wrap(
          
          width = "600px",
          
          fill = FALSE,
          
          bslib::card(
            
            full_screen = TRUE,
            
            height = 575,
            
            bslib::card_header(
              shiny::h4(shiny::div(bsicons::bs_icon("pin-map-fill"), "Trend"))
            ),
            
            bslib::card_body(
              plotly::plotlyOutput(
                "trend"
              )
              
            )
          )
        )
      )
    )
  )
  
  
  ### Prepare the Server ----------------------------------------------------------
  
  server <- function(input, output, session) {
    
    output$trend <- plotly::renderPlotly({
      plot_geography(example_data) 
    })
    
    #ALTERNATIVE IF WE HAVE LOCALLY STORED DATA
    # output$trend <- plotly::renderPlotly({
    #   plot_geography(RshinyDemo::example_data) 
    # })
  }
  
  # Run the application -------------------------------------------
  shiny::shinyApp(ui = ui, server = server)
  
}