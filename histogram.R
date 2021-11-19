library(ggplot2)
library(dplyr)
library(gridExtra)

KaggleData <- read.csv("C:/Users/kelly/Documents/UW/INFO201/final-project-jho0000/data/KaggleData.csv")

KaggleData[KaggleData == 0] <- NA
#View(KaggleData)

KaggleData2 <- na.omit(KaggleData)

perp_age <- KaggleData2 %>%
  select(Perpetrator.Age)
#View(perp_age)

vict_age <- KaggleData2 %>%
  select(Victim.Age)
#View(vict_age)

perp_hist <- ggplot(perp_age, aes(x = Perpetrator.Age)) +
  xlim(0, 100) +
  labs(title="Frequencies of Perpatrator Ages", x = "Age", y = "Count") +
  geom_histogram(color="red", fill="red", alpha=0.5, binwidth = 5) +
  theme_minimal()

vict_hist <- ggplot(vict_age, aes(x = Victim.Age)) +
  xlim(0, 100) +
  labs(title="Frequencies of Victim Ages", x = "Age", y = "Count", fill = "white") +
  geom_histogram(color= "blue", fill= "blue", alpha= 0.5, binwidth = 5, position = "identity") +
  theme_minimal()