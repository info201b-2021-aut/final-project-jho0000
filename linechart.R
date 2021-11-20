#This scatterplot will be the number of incidents by state, from the most recent year

#install packages needed for code
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

KaggleData <- read.csv("../final-project-jho0000/data/KaggleData.csv")
#View(KaggleData)

#Make a new dataset that groups the filtered data set by State and that summarizes 
#the incident column by state, stored in the variable called 'filtered_state'
filtered_year <- KaggleData%>% 
  group_by(Year) %>% 
  summarise(Incident = sum(Incident))
#View(filtered_year)

year_incident_plot <- ggplot(filtered_year, mapping = aes(x = Year)) +
  geom_line(mapping = aes(y = Incident), size = 2)+
  labs(title= "Number of Homicide Incidents in the US from 1980-2014") +
  xlab("Year") +
  ylab("Number of Incidents")