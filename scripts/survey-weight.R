# includes survey weights to data frame

library (dplyr)
data <- read.csv ("../../data/prep-survey-response.csv", stringsAsFactors = FALSE)

demographic <- read.csv ("../../data/uw-population-race-data.csv", stringsAsFactors = FALSE)
demographic <- select (demographic, Population_Ethnicity, Population_Percentage)

sample.race <- unique (data$ethnicity)

# used to attain percentage of given race in a sample/population
Percentage.Race <- function (race) {
  total <- nrow (data)
  specific.race <- nrow (filter (data, ethnicity == race))
  percent <- round (specific.race / total * 100, 2)
  return (percent)
}

sample.race <- as.data.frame (sample.race)
sample.race$percentage <- 0
colnames (sample.race) <- c ("ethnicity", "percentage")

for (i in 1:nrow(sample.race)) {
  sample.race [i, 2] <- Percentage.Race (sample.race[i, 1])
}

sample.race <- left_join (sample.race, demographic, by = c ("ethnicity" = "Population_Ethnicity"))
sample.race <- mutate (sample.race, svy_weight = Population_Percentage / percentage)
sample.race <- select (sample.race, ethnicity, svy_weight)

data <- left_join (data, sample.race)
write.csv (data, "../../data/prep-survey-response.csv")
