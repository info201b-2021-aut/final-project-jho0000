library(ggplot2)
library(dplyr)

KaggleData <- read.csv("C:/Users/kelly/Documents/UW/INFO201/final-project-jho0000/data/KaggleData.csv")

KaggleData[KaggleData == 0] <- NA
View(KaggleData)

KaggleData2 <- na.omit(KaggleData)

perp_age <- KaggleData2 %>%
  select(Perpetrator.Age)
View(perp_age)

vict_age <- KaggleData2 %>%
  select(Victim.Age)
View(vict_age)

ggplot(perp_age, aes(x = Perpetrator.Age)) +
  xlim(0, 100) +
  labs(title="Frequencies of Perpatrator Ages") +
  geom_histogram(color="black", fill="white", alpha=0.5, binwidth = 5)

ggplot(vict_age, aes(x = Victim.Age)) +
  xlim(0, 100) +
  labs(title="Frequencies of Victim Ages") +
  geom_histogram(color="black", fill="white", alpha=0.5, binwidth = 5)

