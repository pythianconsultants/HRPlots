<<<<<<< HEAD
shinyServer(function(input, output) {
  
  output$box <- renderPlotly({
    master2 <- master%>%filter(Status %in% input$fillvalue)
    p <- ggplot(master2, aes_string(x=input$xvalue))+geom_bar(aes(fill=Status))
    ggplotly(p+theme(axis.text.x=element_blank(),axis.ticks=element_blank()))
})
})

ggplot(cnv, aes(reorder(Date,Count),Count,fill=URL))+
  geom_bar(stat="identity")+coord_flip()


=======
shinyServer(function(input, output) {
  
  output$box <- renderPlotly({
    
    p <- ggplot(master3, aes_string(x=input$xvalue,fill=input$fillvalue))+geom_bar()
    ggplotly(p)
})
})
#Added a comment



>>>>>>> 019cebe1a9bf1903946219b87c5724ab67ac5c37
