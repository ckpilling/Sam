library(shiny)
if (!exists("all_cities")) all_cities = readRDS("data/cities.rds")
if (!exists("usa_cities")) usa_cities = readRDS("data/usa_cities.rds")

shinyUI(fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="custom_styles.css")
  ),
  
  title = "Sam tours US",
  
  tags$h2(tags$a(href="http://www.fujitsu.com", "Create a US tour for Sam and optimise it!", target="_blank")),
  
  plotOutput("map", height="550px"),
  
  fluidRow(
    column(5,
      tags$ol(
        tags$li("Pick cities for Sam's gigs"),
        tags$li("Adjust simulated annealing parameters"),
        tags$li("Click the 'Optimise Now!' button!")
      )
    ),
    column(3,
      tags$button("Optimise Now!", id="go_button", class="btn btn-info btn-large action-button shiny-bound-input")
    ),
      column(3,
      HTML("<button id='set_random_cities_2' class='btn btn-small action-button shiny-bound-input' style='background-color:white;color:white'>
            </button>")
    ), class="aaa"
  ),
  
  hr(),
  
  hr(),
  
  fluidRow(
    column(5,
      p("Type the cities for Sam's gigs, or", actionButton("set_random_cities", "pick random cities", icon=icon("refresh"))),
      selectizeInput("cities", NA, all_cities$full.name, multiple=TRUE, width="100%",
                     options = list(maxItems=30, maxOptions=100, placeholder="Start typing to select some cities...",
                                    selectOnTab=TRUE, openOnFocus=FALSE, hideSelected=TRUE)),
      checkboxInput("label_cities", "Label cities on map?", FALSE)
    ),
    
    column(2,
      h4("Annealing Parameters"),
      inputPanel(
        numericInput("total_iterations", "Number of Iterations to Run", 100000, min=0, max=1000000, width="500px"),
        numericInput("plot_every_iterations", "Draw Map Every N Iterations", 750, min=1, max=1000000)
      ),
      class="numeric-inputs"
    ),
    
    column(5,
      plotOutput("annealing_schedule", height="260px"),
      plotOutput("distance_results", height="260px")
    ),
    
    hr(),
    
   fluidRow(
    column(3,  
     selectInput("map_name", NA, c("World", "USA"), "World", width="300px")
   )
  )
 )   
))
