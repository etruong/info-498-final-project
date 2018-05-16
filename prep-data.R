library (dplyr)

data <- read.csv ("data/survey-response.csv")
col.name <- c ("timestamp", "first_word", "gender", "ethnicity", "age", "school", "major", "minor", 
               "mental_health", "microaggression", "microcompassion", "memes", "first_see", "location_see",
               "link", "feel_change", "feel_change_explain", "uplift", "discourage", 
               "behavior_change", "behavior_change_explain", "talk_sign", "talk_sign_explain", 
               "effective")
colnames (data) <- col.name

write.csv ("data/prep-survey-response.csv")
