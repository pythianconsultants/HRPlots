shinyServer(function(input, output) {
  # xv <- reactive({input$xvalue})
  # fillv <- reactive({input$fillvalue})
  obs <- reactive({input$obs})
  # smoothMethod <- reactive({input$smoothMethod})
  # alpha <- reactive({input$alpha})
  # type <- reactive({input$type})
  
  output$box <- renderPlotly({
    
  #   p <- ggplot(wine, aes_string(x=xv(), y=yv()))+geom_point(alpha=alpha())
  #   
  #   if(type()) p <- p <- ggplot(wine, aes_string(x=xv(), y=yv(), color="type"))+
  #       geom_point(alpha=alpha())
  #   if(smooth()) p <- p+geom_smooth(method=smoothMethod())
  #   ggplotly(p)
  #   
  # })
  # 
  # output$qlty <- renderPlotly({
  #   q <- ggplot(qt, aes_string(x='Attribute', y='log(avg)',fill="type"))+geom_bar(stat='identity')+facet_wrap(type~qlty)
  #   ggplotly(q)
  # })
    
    
    
    p <- ggplot(master_complete, aes_string(x=input$xvalue,fill=input$fillvalue))+
      geom_bar()
    ggplotly(p)
})
})




