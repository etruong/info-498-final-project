library(dplyr)
library(ggplot2)
library(plotly)
library(jsonlite)
library(plyr)

source("scripts/prep-data.R")
source("scripts/data-cleaning.R")
# For more information about downloading Google API credentials, check the README within
# the sentiment-analysis folder
words <- as.data.frame(sort(trimws(tolower(data$first_word))))
colnames(words) <- c("first_word")

words_frequencies <- count(words, 'first_word')
write(toJSON(words_frequencies, pretty = TRUE), "scripts/sentiment-analysis/frequencies.json")


google_credentials_path <- "/Users/afruitpie/Documents/Keys/Sentiment-Test-d758d2a3594d.json"
command <- paste0('export GOOGLE_APPLICATION_CREDENTIALS="',
                  google_credentials_path,
                  '" && node scripts/sentiment-analysis/index.js')

if (!file.exists("data/frequencies_with_sentiment.json")) {
  cat("Uh oh, the sentiment analysis is not done! This might take a minute to finish...")
  system(command)
}

sentiments <- as.data.frame(read_json("data/frequencies_with_sentiment.json"))

words_histogram <- ggplot(words, aes(first_word)) + 
  geom_histogram(stat = "count") + 
  coord_flip()
 