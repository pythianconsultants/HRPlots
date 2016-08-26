shinyServer(function(input, output) {
  
  output$box <- renderPlotly({
    master2 <- master%>%filter(Status %in% input$fillvalue)
    p <- ggplot(master2, aes_string(x=input$xvalue))+geom_bar(aes(fill=Status))
    ggplotly(p+theme(axis.text.x=element_blank(),axis.ticks=element_blank()))
})
})

ggplot(cnv, aes(reorder(Date,Count),Count,fill=URL))+
  geom_bar(stat="identity")+coord_flip()


