library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

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

#Filter for job ads which got released
released <- master%>%filter(Status=='Released')

#Read in joining data (Table 2)
joining <- read.csv("joining.csv")

#Repeat URL and Job IDs as per vaccancies
URL <- rep(released$URL,released$No.of.vacancies)
Job.ID <- rep(released$Job.ID,released$No.of.vacancies)

#Some basic cleaning
joining$Candidate.ID[joining$Candidate.ID=='C00001'] <- "C0001"
joining$Candidate.ID <- factor(joining$Candidate.ID)

#Randomly assign candidates to these jobs
candidates <- sample(joining$Candidate.ID, length(URL),replace=T)

#Shortlisting Date
JIRD <- rep(released$Job.ID.Release.Date,released$No.of.vacancies)
Shortlisting.Date <- JIRD+runif(length(JIRD),min = 2,max = 7)
ind <- which(Shortlisting.Date %in% sample(Shortlisting.Date, 0.3*length(Shortlisting.Date)))
Shortlisting.Date[ind] <- NA
#Screening Date
Screening.Date <- Shortlisting.Date+runif(length(JIRD),min = 2,max = 10)

#Review Date
Review.Date <- Screening.Date+runif(length(JIRD),min = 2,max = 7)

#Interview Date
Interview.Date <- Review.Date+runif(length(JIRD),min = 2,max = 9)

#Offer Submission Date
OSD <- Interview.Date+runif(length(JIRD),min = 1,max = 4)

#Offer Approval Date
OAD <- OSD+runif(length(JIRD),min = 2,max = 5)

#Offer Acceptance Date
OACD <- OAD+runif(length(JIRD),min = 1,max = 5)

#Date Of Joining
DOJ <- OACD+runif(length(JIRD),min = 7,max = 20)


#Combine all in one data frame
test <- cbind.data.frame(URL,Job.ID,candidates,Shortlisting.Date,Screening.Date,
                         Review.Date,Interview.Date,OSD,OAD,OACD,DOJ)

