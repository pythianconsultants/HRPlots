library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

master <- read.csv("master.csv")


#Convert dates to date format
master[3:5] <- lapply(master[3:5], dmy)

master$Recruiter.Code[master$Recruiter.Code==""] <- "1796"
master$Recruiter.Code <- factor(master$Recruiter.Code)

master <- mutate(master, ap_cr=(Job.ID.Approval.Date-Job.ID.Creation.Date),
                 rl_cr=(Job.ID.Release.Date-Job.ID.Approval.Date),
                 cuml=(Job.ID.Release.Date-Job.ID.Creation.Date))
released <- master%>%filter(Status=='Released')

joining <- read.csv("joining.csv")

URL <- rep(released$URL,released$No.of.vacancies)
Job.ID <- rep(released$Job.ID,released$No.of.vacancies)


joining$Candidate.ID[joining$Candidate.ID=='C00001'] <- "C0001"
joining$Candidate.ID <- factor(joining$Candidate.ID)

candidates <- sample(joining$Candidate.ID, length(URL),replace=T)

test <- cbind.data.frame(URL,Job.ID,candidates)


