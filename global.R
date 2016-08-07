library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

master <- read.csv("master.csv")
master$Job.ID.Release.Date <- dmy(master$Job.ID.Release.Date)

#Replace low values in CTC with mean
master$Min.CTC[master$Min.CTC<100] <- round(mean(master$Min.CTC))
master$Max.CTC[master$Max.CTC<100] <- round(mean(master$Max.CTC))

master_complete <- master[complete.cases(master$Job.ID.Release.Date),]
master_complete <- master_complete%>%mutate(Year=year(Job.ID.Release.Date),
                                            Month=month(Job.ID.Release.Date))





