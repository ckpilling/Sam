library(shiny)
if (!exists("usa_cities")) usa_cities = readRDS("data/usa_cities.rds")

shinyUI(fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="custom_styles.css")
  ),
  
  title = "Als tours US",
  
  tags$h2(tags$a(href="http://www.fujitsu.com", "Create a US tour for Als' and optimise it!", target="_blank")),
  
  plotOutput("map", height="550px"),
  
  fluidRow(
    column(5,
      tags$ol(
        tags$li("Pick cities for Als' gigs"),
        tags$li("Adjust parameters (optional)"),
        tags$li("Click the 'Optimise Now!' button!")
      )
    ),
    column(3,
      tags$button("Optimise Now!", id="go_button", class="btn btn-info btn-large action-button shiny-bound-input")
    )
  ),
  
  hr(),
  
  fluidRow(
    column(5,
      p("Type the cities for Als' gigs, or", actionButton("set_random_cities", "auto pick cities", icon=icon("refresh"))),
      selectizeInput("cities", NA, all_cities$full.name, multiple=TRUE, width="100%",
                     options = list(maxItems=30, maxOptions=100, placeholder="Start typing to select cities",
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
    
    hr(),
    
   fluidRow(
    column(3,  
     selectInput("map_name", NA, c("World", "USA"), "World", width="0px")
   )
  )
 )   
))
