
library(shiny)

shinyUI(navbarPage(title=div(img(src="logo.png", width="60%")),
                   tabPanel("Recruiters",
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
                                plotlyOutput("box"),
                                h3("Assessing Jobs By Recruiters/URL"),
                                p("The chart above shows you the number of jobs for each recruiter or URL. The user can change the x-axis to select
                                  either Recruiters or URL. The y-axis shows the count of jobs as per the Recruiters/URL.
                                  Also, the user can apply filters based on the status of the jobs from the available 7 options by checking
                                  /unchecking the check-boxes in the Fill By field."),
                                br(),
                                p("By hovering the mouse over the chart, values can be read off. The top right corner
                                  of the chart also provides the following options:-"),
                                cat(sum(master$Status=='Released')),
                                tags$li("Download as png"),
                                tags$li("Zoom"),
                                tags$li("Pan"),
                                tags$li("Autoscale"),
                                tags$li("Reset Axes"),
                                tags$li("Compare Data On Hover"),
                                h4(textOutput("text1"))
                                
                              )
                            )
                            ),
                   tabPanel("Time To Fill",
                            column(12,offset=1,
                                   mainPanel(plotlyOutput("tat"))
                            ))
        )
    )
