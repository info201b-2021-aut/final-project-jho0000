#This scatterplot will be the number of incidents by state, from the most recent year

#install packages needed for code
install.packages("tidyverse")
library(tidyverse)

install.packages("dplyr")
library(dplyr)

install.packages("ggplot2")
library(ggplot2)

library(readr)
KaggleData <- read_csv("~/final-project-jho0000/data/KaggleData.csv")
View(KaggleData)

#Make a new dataset that groups the filtered data set by State and that summarizes 
#the incident column by state, stored in the variable called 'filtered_state'
filtered_year<-KaggleData%>% 
  group_by(Year) %>% 
  summarise(Incident = sum(Incident))
#View(filtered_year)

year_incident_plot<- ggplot(filtered_year, mapping= aes(x = Year))+
  geom_line(mapping = aes(y=Incident), size= 2)+
  labs(title= "Number of Homicide Incidents in the US from 1980-2014")+
  xlab("Year of Incident")+
  ylab("Number of Incidents")
plot(year_incident_plot)

