library(ggplot2)
library(dplyr)

KaggleData <- read.csv("../final-project-jho0000/data/KaggleData.csv") 

homocide_data <- select(KaggleData, State, City, Year, Month, Relationship, Weapon, Incident)

weapons <- homocide_data %>% group_by(Weapon) %>% summarise(Weapon_Incidents = sum(Incident))

top10_weapons <- weapons[-c(16),] %>% top_n(10,Weapon_Incidents)

#this is the code for the barchart
weapon_barchart <- ggplot(top10_weapons) + 
  geom_col(mapping = aes(x= Weapon, y = Weapon_Incidents, fill = Weapon))+
  labs(title = "Top 10 Weapons in the U.S. Used for Homocide", 
       x = "Weapon Name",
       y = "Number of Homocide Incidents Caused by Weapon")+
  theme(text=element_text(size=17))