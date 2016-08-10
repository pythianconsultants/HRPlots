library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

master <- read.csv("master.csv")
joining <- read.csv("joining.csv")
cand <- read.csv("cand.csv")

#Convert dates to date format
master[3:4] <- lapply(master[3:4], mdy)
master$Job.ID.Release.Date <- dmy(master$Job.ID.Release.Date)
#Add some randomness to Release date
rnd_days <- ceiling(runif(nrow(master),0,10))
master$Job.ID.Release.Date <- master$Job.ID.Release.Date+ddays(rnd_days)

master$new <- dmy(master$new)
#Replace low values in CTC with mean
master$Min.CTC[master$Min.CTC<100] <- round(mean(master$Min.CTC))
master$Max.CTC[master$Max.CTC<100] <- round(mean(master$Max.CTC))

master_complete <- master[complete.cases(master$Job.ID.Release.Date),]
master_complete <- master_complete%>%mutate(Year=year(Job.ID.Release.Date),
                                            Month=month(Job.ID.Release.Date))





