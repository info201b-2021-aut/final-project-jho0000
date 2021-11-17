library(ggplot2)
library(dplyr)

#bar chart of top 10 weapons used in homocide cases
#i made a temp brachrtvisualize.Rmd file to show you what it should look like, make sure
#pay attention to the the header of the code in the RMD file, specifically this
#```{r weapons, fig.width=14,fig.height=8}
#this defines the size of the chart

KaggleData <- read.csv("../final-project-jho0000/data/KaggleData.csv")

homocide_data <- select(KaggleData, State, City, Year, Month, Relationship, Weapon, Incident)

weapons <- homocide_data %>% group_by(Weapon) %>% summarise(Weapon_Incidents = sum(Incident))

top10_weapons <- weapons[-c(16),] %>% top_n(10,Weapon_Incidents)

#this is the code for the barchart
weapon_barchart <- ggplot(top10_weapons) + 
  geom_col(mapping = aes(x= Weapon, y = Weapon_Incidents, fill = Weapon))+
  labs(title = "Top 10 Weapons in the US used for Homocide", 
       x = "Weapon Name",
       y = "Number of Homocide Incidents Caused by Weapon")+
  theme(text=element_text(size=17))

#this is some practice code for scatterplot
# US_Incidents <- homocide_data %>% group_by(Year) %>% summarise(sumIncidents = sum(Incident))
# NumIncidents_scatterplot <- ggplot(US_Incidents) +
#   geom_point(mapping = aes(x= Year, y = sumIncidents)) +
#   geom_line(mapping = aes(x= Year, y = sumIncidents)) +
#   labs(title = "Number of Homocide Incidents in the US over the years, 1980 - 2014", 
#        x = "Year",
#        y = "Number of Homocide Incidents")+
#   theme(text=element_text(size=17))
