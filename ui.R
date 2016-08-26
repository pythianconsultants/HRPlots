
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
                  choices = c("URL","Recruiter.Code")        
      ),
      checkboxGroupInput(inputId="fillvalue",
                  label = "Fill by",
                  choices = levels(master$Status),selected = c("Closed","Submitted")
      ),
      width=3
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("box")
      
    )
  )
))
#
