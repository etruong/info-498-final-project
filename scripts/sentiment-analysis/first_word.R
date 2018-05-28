library(dplyr)
library(ggplot2)
library(plotly)

source("../prep-data.R")

words <- as.data.frame(x = sort(trimws(tolower(data$first_word))))
colnames(words) <- c("words")

words_histogram <- ggplot(words, aes(words)) + 
  geom_histogram(binwidth = 5, stat = "count") + 
  coord_flip()

print(words_histogram)