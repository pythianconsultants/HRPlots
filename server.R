shinyServer(function(input, output) {
  
  output$box <- renderPlotly({
    
    p <- ggplot(master_complete, aes_string(x=input$xvalue,fill=input$fillvalue))+
      geom_bar()
    ggplotly(p)
})
})




