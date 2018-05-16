library(dplyr)
library(ggplot2)
library(plotly)

source("scripts/prep-data.R")

words <- as.data.frame(x = sort(trimws(tolower(survey$What.is.the.first.word.that.comes.to.your.mind.when.you.see.this.sign.))))
colnames(words) <- c("words")

words_histogram <- ggplot(words, aes(words)) + 
  geom_histogram(binwidth = 5, stat = "count") + 
  coord_flip()

words_string <- paste(names, sep = "", collapse=" ")

print(words_histogram)