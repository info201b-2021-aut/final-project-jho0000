library(tidyverse)

# Sourcing data

KaggleData <- read.csv("C:/Users/John/Desktop/UW Note/INFO 201/GitHubDub/final-project-jho0000/data/KaggleData.csv")

#What is the average victim age for murders in Washington (as of the most recent year)?
avg_vicage_wa <- filter(KaggleData, Year == max(Year))
avg_vicage_wa <- filter(avg_vicage_wa, State == "Washington")
avg_vicage_wa <- summarize(avg_vicage_wa, average = mean(13))
avg_vicage_wa <- select(avg_vicage_wa, average)
#View(avg_vicage_wa)
#Answer: 13

#Highest number of homicides reported in a single city for each state
most_homicide <- select(KaggleData, City, State, Year, Incident)
most_homicide <- group_by(most_homicide, State)
most_homicide <- group_by(most_homicide, City, .add = TRUE)
most_homicide <- summarize(most_homicide, cumulation = sum(Incident))
most_homicide <- summarize(most_homicide, MaxHomicide = max(cumulation))
#View(most_homicide)

#Amount of cities with the smallest number of homicides (across all years, cumulative) 
smallest_homicide <- select(KaggleData, City, State, Year, Incident)
smallest_homicide <- group_by(smallest_homicide, City)
smallest_homicide <- summarize(smallest_homicide, Incident_Sums = sum(Incident)) 
smallest_homicide <- filter(smallest_homicide, Incident_Sums == min(Incident_Sums)) 
smallest_homicide <- nrow(smallest_homicide)
#View(smallest_homicide)
#Answer: 53

#Largest number of homicides (across all years, cumulative) in a single state
most_homicide2 <- select(KaggleData, City, State, Year, Incident)
most_homicide2 <- group_by(most_homicide2, State)
most_homicide2 <- summarize(most_homicide2, MaxHomicide = sum(Incident))
most_homicide2 <- filter(most_homicide2, MaxHomicide == max(MaxHomicide))
#View(most_homicide2)
#Answer: Florida (8100400)

#How many columns are in the dataset?
num_columns <- ncol(KaggleData)
#Answer: 24

#How many rows are in the dataset?
num_rows <- nrow(KaggleData)
#Answer: 638454

#return information as list
summary_list <- list("Average Victim Age" = 13, "Highest number of homicides reported in a single city for each state" = most_homicide, "Amount of cities with the smallest number of homicides" = smallest_homicide, "Largest number of homicides (across all years, cumulative) in a single state" = most_homicide2, "Number of Columns" = num_columns, "Number of Rows" = num_rows)
#View(summary_list)
