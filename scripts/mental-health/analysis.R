
# setwd("~/Desktop/Classes/INFO_498/wb-8-kasfranco/MentalHealthAndMicroExperiences")

library(dplyr)
library(ggplot2)
library(tidyr)
library(reshape2)
library(plotly)

data <- read.csv("./ResilienceLabSignSurvey.csv")
prepped_data <- 
  select(data, 
         How.would.you.rate.your.mental.health.., 
         In.relation.to.your.peers..to.what.degree.do.you.experience.microaggressions., 
         In.relation.to.your.peers..to.what.degree.do.you.experience.microcompassions.) #,

colnames(prepped_data) <- 
  c("ment.health", "microaggression", "microcompassion") #, "effective") 
  # ment.health: 1 poor, 5 excellent
  # microaggression: 1 less, 5 more
  # microcompassion: 1 less, 5 more

prepped_data <- 
  filter(prepped_data, !is.na(ment.health)) %>% 
  filter(!is.na(microaggression)) %>% 
  filter(!is.na(microcompassion))

gathered_data <- gather(prepped_data, "microexperience", "rating", 2:3) 

plot <- 
  ggplot(gathered_data, aes(x = ment.health, y = rating, col = microexperience)) +
  geom_jitter() +
  labs(x = "Rating of Own Mental Health (Poor: 1, Excellent: 5)",
       y = "Perception of Microexperience (Less: 1, More: 5)",
       col = "Microexperience, Relative to Peers")

plotly <- ggplotly(plot)
