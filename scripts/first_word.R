library(dplyr)
library(ggplot2)
library(plotly)
library(jsonlite)
library(plyr)

source("scripts/prep-data.R")
source("scripts/data-cleaning.R")

# For more information about downloading Google API credentials, check the README within
# the sentiment-analysis folder
google_credentials_path <- "/Users/afruitpie/Documents/Keys/Sentiment-Test-d758d2a3594d.json"

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

sentiments <- read_json("data/frequencies_with_sentiment.json")


sentiments_df = data_frame(first_word = unlist(sentiments["first_word"]), freq = unlist(sentiments["freq"]), sentiment = unlist(sentiments["sentiment"]), magnitude = unlist(sentiments["magnitude"]))


#for(element in sentiments) {
#  sentiments_df[nrow(sentiments_df) + 1] = c(element[1], element[2], element[3])
#}