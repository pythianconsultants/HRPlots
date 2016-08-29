
shinyServer(function(input, output) {
  
  output$box <- renderPlotly({
    master2 <- master%>%filter(Status %in% input$fillvalue)
    p <- ggplot(master2, aes_string(x=input$xvalue))+geom_bar(aes(fill=Status))
    ggplotly(p+theme(axis.text.x=element_blank(),axis.ticks=element_blank()))
})


output$tat <- renderPlotly({
cnv <- as.data.frame(cnv)
cnv$Date <- factor(cnv$Date)
p <- ggplot(cnv, aes(reorder(Date,Count),Count,fill=Date))+geom_bar(stat="identity")+coord_flip()+scale_x_discrete(labels=c("Date of Joinng","Offer Accepted","Offers Approved","Offers Submitted","Interviewed","Reviewed","Screened","Shortlisted"))
ggplotly(p+xlab(NULL))
})

output$text1 <- renderText({paste("Total number of jobs Released", sum(master$Status=='Released'))})

})
