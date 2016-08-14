library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

master <- read.csv("master.csv")


#Convert dates to date format
master[3:4] <- lapply(master[3:4], mdy)
master$Job.ID.Release.Date <- dmy(master$Job.ID.Release.Date)

#function for generating random dates
rand.date=function(start.day,end.day,data){   
  size=dim(data)[1]    
  days=seq.Date(start.day,end.day,by="day")  
  pick.day=runif(size,1,length(days))  
  date=days[pick.day]  
}

master2 <- master
master2$Job.ID.Creation.Date <- rand.date(min(master$Job.ID.Creation.Date, na.rm=T),
                                          max(master$Job.ID.Creation.Date,na.rm=T),master2)

rnd_days <- ceiling(runif(nrow(master2),2,10))
master2$Job.ID.Approval.Date <- master2$Job.ID.Creation.Date+ddays(rnd_days)

rnd_days2 <- ceiling(runif(nrow(master2),2,15))
master2$Job.ID.Approval.Date <- master2$Job.ID.Approval.Date+ddays(rnd_days2)

#Create new time difference variables
master2$app_crt <- difftime(master2$Job.ID.Approval.Date,master2$Job.ID.Creation.Date,"days")

master2$rls_crt <- difftime(master2$Job.ID.Release.Date,master2$Job.ID.Creation.Date,"days")

#Replace low values in CTC with mean
master2$Min.CTC[master2$Min.CTC<100] <- round(mean(master2$Min.CTC))
master2$Max.CTC[master2$Max.CTC<100] <- round(mean(master2$Max.CTC))

#Consider complete cases
master3 <- master2[complete.cases(master2),]

jobs <- master2%>%group_by(Job.ID)%>%summarise(Count=n())%>%filter(Count>1)




