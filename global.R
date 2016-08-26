library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)
library(tidyr)

#Read in the data (Table 1)
master <- read.csv("master.csv")


#Convert dates to date format
master[3:5] <- lapply(master[3:5], dmy)

#Replace missng recruiter code
master$Recruiter.Code[master$Recruiter.Code==""] <- "1796"
master$Recruiter.Code <- factor(master$Recruiter.Code)

#Add date differences
master <- mutate(master, ap_cr=(Job.ID.Approval.Date-Job.ID.Creation.Date),
                 rl_cr=(Job.ID.Release.Date-Job.ID.Approval.Date),
                 cuml=(Job.ID.Release.Date-Job.ID.Creation.Date))


#Filter for job ads which got Closed
Closed <- master%>%filter(Status=='Closed')


#Read in joining data (Table 2)
joining <- read.csv("joining.csv")

#Repeat URL and Job IDs as per vaccancies

URL <- rep(Closed$URL,Closed$No.of.vacancies)
Job.ID <- rep(Closed$Job.ID,Closed$No.of.vacancies)


#Some basic cleaning
joining$Candidate.ID[joining$Candidate.ID=='C00001'] <- "C0001"
joining$Candidate.ID <- factor(joining$Candidate.ID)

#Randomly assign candidates to these jobs
candidates <- sample(joining$Candidate.ID, length(URL),replace=T)

#Shortlisting Date

JIRD <- rep(Closed$Job.ID.Release.Date,Closed$No.of.vacancies)
Shortlisting.Date <- JIRD+runif(length(JIRD),min = 2,max = 7)
ind <- which(Shortlisting.Date %in% sample(Shortlisting.Date, 0.5*length(Shortlisting.Date)))
Shortlisting.Date[ind] <- NA
#Screening Date
Screening.Date <- Shortlisting.Date+runif(length(JIRD),min = 2,max = 10)
indx <- which(!is.na(Screening.Date))
Screening.Date[sample(indx,0.3*length(indx))] <- NA
#Review Date
Review.Date <- Screening.Date+runif(length(JIRD),min = 2,max = 7)
indx <- which(!is.na(Review.Date))
Review.Date[sample(indx,0.4*length(indx))] <- NA
#Interview Date
Interview.Date <- Review.Date+runif(length(JIRD),min = 2,max = 9)
indx <- which(!is.na(Interview.Date))
Interview.Date[sample(indx,0.3*length(indx))] <- NA
#Offer Submission Date
OSD <- Interview.Date+runif(length(JIRD),min = 1,max = 4)
indx <- which(!is.na(OSD))
OSD[sample(indx,0.25*length(indx))] <- NA
#Offer Approval Date
OAD <- OSD+runif(length(JIRD),min = 2,max = 5)
indx <- which(!is.na(OAD))
OAD[sample(indx,0.15*length(indx))] <- NA
#Offer Acceptance Date
OACD <- OAD+runif(length(JIRD),min = 1,max = 5)
indx <- which(!is.na(OACD))
OACD[sample(indx,0.1*length(indx))] <- NA
#Date Of Joining
DOJ <- OACD+runif(length(JIRD),min = 7,max = 20)
indx <- which(!is.na(DOJ))
DOJ[sample(indx,0.5*length(indx))]<- NA

#Combine all in one data frame
test <- cbind.data.frame(URL,Job.ID,candidates,Shortlisting.Date,Screening.Date,
                         Review.Date,Interview.Date,OSD,OAD,OACD,DOJ)


conv <- gather(test, Date, Value, Shortlisting.Date:DOJ)
cnv <- conv%>%filter(!is.na(Value))%>%group_by(URL,Date)%>%summarize(Count=n())

