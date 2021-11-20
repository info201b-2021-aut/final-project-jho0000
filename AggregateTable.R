Average_Victim_Age <- "13"
Amount_of_Cities_With_The_Smallest_Number_of_Homicides <- "53"
Largest_Number_of_Homicides_in_a_Single_State <- "8100400"
Number_of_Columns <- "24"
Number_of_Rows <- "638454"
Kaggle <- data.frame(Average_Victim_Age, Amount_of_Cities_With_The_Smallest_Number_of_Homicides, Largest_Number_of_Homicides_in_a_Single_State, Number_of_Columns, Number_of_Rows)
Kaggle
knitr::kable(Kaggle, "pipe", col.names = c("Average_Victim_Age", "Amount_of_Cities_With_The_Smallest_Number_of_Homicides", "Largest_Number_of_Homicides_in_a_Single_State", "Number_of_Columns", "Number_of_Rows"), align = c("l", "c", "c", "c", "r"))