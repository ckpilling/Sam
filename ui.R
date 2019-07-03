library(shiny)
if (!exists("all_cities")) all_cities = readRDS("data/cities.rds")
if (!exists("usa_cities")) usa_cities = readRDS("data/usa_cities.rds")

shinyUI(fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="custom_styles.css")
  ),
  
  title = "Sam in America",
  
  tags$h2(tags$a(href="http://www.fujitsu.com", "Create your own tour", target="_blank")),
  
  plotOutput("map", height="550px"),
  
  fluidRow(
    column(5,
      tags$ol(
        tags$li("Pick your favourite US cities"),
        tags$li("Adjust the simulated annealing parameters"),
        tags$li("Click the 'Route Me' button!")
      )
    ),
    column(3,
      tags$button("Route Me", id="go_button", class="btn btn-info btn-large action-button shiny-bound-input")
    ),
      
  hr(),
  
  fluidRow(
    column(5,
      h4("Choose cities to tour"),
      selectInput("map_name", NA, c("World", "USA"), "World", width="100px"),
      p("Type below to select individual cities, or", actionButton("set_random_cities", "set randomly", icon=icon("refresh"))),
      selectizeInput("cities", NA, all_cities$full.name, multiple=TRUE, width="100%",
                     options = list(maxItems=30, maxOptions=100, placeholder="Start typing to select some cities...",
                                    selectOnTab=TRUE, openOnFocus=FALSE, hideSelected=TRUE)),
      checkboxInput("label_cities", "Label cities on map?", FALSE)
    ),
    
    column(2,
      h4("Simulated Annealing Parameters"),
      inputPanel(
        numericInput("s_curve_amplitude", "S-curve Amplitude", 4000, min=0, max=10000000),
        numericInput("s_curve_center", "S-curve Center", 0, min=-1000000, max=1000000),
        numericInput("s_curve_width", "S-curve Width", 3000, min=1, max=1000000),
        numericInput("total_iterations", "Number of Iterations to Run", 25000, min=0, max=1000000),
        numericInput("plot_every_iterations", "Draw Map Every N Iterations", 1000, min=1, max=1000000)
      ),
      class="numeric-inputs"
    ),
    
    column(5,
      plotOutput("annealing_schedule", height="260px"),
      plotOutput("distance_results", height="260px")
    )
  )
))
