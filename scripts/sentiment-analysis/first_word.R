library(dplyr)
library(ggplot2)
library(plotly)
library(jsonlite)
library(plyr)
library(wordcloud2)

source("scripts/prep-data.R")

# For more information about downloading Google API credentials, check the README within
# the sentiment-analysis folder
google_credentials_path <- "/Users/afruitpie/Documents/Keys/Sentiment-Test-d758d2a3594d.json"

words <- as.data.frame(sort(trimws(tolower(data$first_word))))
colnames(words) <- c("first_word")

words_frequencies <- count(words, 'first_word')
write(toJSON(words_frequencies, pretty = TRUE), "scripts/sentiment-analysis/sentiment-analysis/frequencies.json")

google_credentials_path <- "/Users/afruitpie/Documents/Keys/Sentiment-Test-d758d2a3594d.json"
command <- paste0('export GOOGLE_APPLICATION_CREDENTIALS="',
                  google_credentials_path,
                  '" && node sentiment-analysis/index.js')

if (!file.exists("../../data/frequencies_with_sentiment.json")) {
  cat("Uh oh, the sentiment analysis is not done! This might take a minute to finish...")
  system(command)
}

sentiments <- read_json("data/frequencies_with_sentiment.json")


sentiments_df = data_frame(first_word = unlist(sentiments["first_word"]),
                           freq = unlist(sentiments["freq"]), 
                           sentiment = unlist(sentiments["sentiment"]),
                           magnitude = unlist(sentiments["magnitude"]))

wordCloud <- wordcloud2(words_frequencies, size = 1.5)

getFilteredPlot <- function(min_freq, magnitude_bool) {
  tempSentiments <- sentiments_df %>% filter(sentiment != 0.0 & freq > min_freq)
  if (magnitude_bool) {
    tempSentiments$sentiment <- tempSentiments$sentiment * tempSentiments$magnitude
  }
  
  filteredPlot <- tempSentiments %>%
    ggplot(aes(first_word, sentiment, fill = freq)) +
    geom_bar(stat = "identity") + 
    # coord_flip() + 
    xlab("Words") + 
    ylab("Sentiment (-1 is poor, +1 is positive)") +
    ggtitle("Words and their sentiment scores", subtitle = "Sentiment analysis done by Google Natural Language API") +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.45))
  filteredPlot <- ggplotly(filteredPlot)
  filteredPlot
}

getDescription <- function(min_freq, magnitude_bool) {
  tempSentiments <- sentiments_df %>% filter(sentiment != 0.0 & freq > min_freq)
  if (magnitude_bool) {
    tempSentiments$sentiment <- tempSentiments$sentiment * tempSentiments$magnitude
  }
  description <- paste("For the", nrow(tempSentiments), "words that are selected, the average sentiment is", sum(tempSentiments$sentiment), ". Values closer to 1 are more positive, 'happy' words, and words closer to -1 are 'unhappy' words.") 
  description
}