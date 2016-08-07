
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Descriptive Analytics - EazeHR"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="xvalue",
                  label = "Value for X-axis",
                  choices = c(names(master_complete))        
      ),
      selectInput(inputId="fillvalue",
                  label = "Fill by",
                  choices = c("Recruiter.Code","Year")
      )
      # sliderInput(inputId="obs",label="Minimum Observations",min=0,max=5,value=0, step=1)
      # checkboxInput("smooth", "Smooth"),
      # conditionalPanel(
      #   condition = "input.smooth == true",
      #   selectInput("smoothMethod", "Method",
      #               list("lm", "glm", "gam", "loess"))
      # ),
    #   checkboxInput("type", "Segregate by Wine Type")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("box")
      # plotlyOutput("qlty")
    )
  )
))
