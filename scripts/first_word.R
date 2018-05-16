library(dplyr)
library(ggplot2)
library(plotly)
library(jsonlite)

source("scripts/prep-data.R")
source("data-cleaning.R")
# For more information about downloading Google API credentials, check the README within
# the sentiment-analysis folder
google_credentials_path <- "/Users/afruitpie/Documents/Keys/Sentiment-Test-d758d2a3594d.json"
command <- paste0('export GOOGLE_APPLICATION_CREDENTIALS="',
                  google_credentials_path,
                  '" && node scripts/sentiment-analysis/index.js')
system(command)

words <- as.data.frame(x = sort(trimws(tolower(data$first_word))))
colnames(words) <- c("first_word")


words_histogram <- ggplot(words, aes(first_word)) + 
  geom_histogram(stat = "count") + 
  coord_flip()
 
print(words_histogram)