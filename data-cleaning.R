library(dplyr)
data <- read.csv('./data/prep-survey-response.csv')

# CLEAN FIRST WORD COLUMN
data$first_word <- tolower(data$first_word)
# first_words <- data %>% arrange(first_word)
# first_words <- unique(data$first_word)
# print(sort(first_words))

data$first_word[data$first_word == 'boundless '] <- 'boundless'
data$first_word[data$first_word == 'uw_bullshit'] <- 'bullshit'
data$first_word[data$first_word == 'business'] <- 'busy'
data$first_word[data$first_word == 'busyness'] <- 'busy'
data$first_word[data$first_word == 'imbusy'] <- 'busy'
data$first_word[data$first_word == 'confused'] <- 'confusing'
data$first_word[data$first_word == 'confusion'] <- 'confusing'
data$first_word[data$first_word == 'encourage'] <- 'encouragement'
data$first_word[data$first_word == 'fake'] <- 'false'
data$first_word[data$first_word == 'lies'] <- 'false'
data$first_word[data$first_word == 'good '] <- 'good'
data$first_word[data$first_word == 'nice  '] <- 'cool'
data$first_word[data$first_word == 'nope'] <- 'no'
data$first_word[data$first_word == 'oh'] <- 'okay'
data$first_word[data$first_word == 'really'] <- 'really?'
data$first_word[data$first_word == 'stressolympics'] <- 'stressed'
data$first_word[data$first_word == 'huh?'] <- 'what?'
data$first_word[data$first_word == 'wording?'] <- 'what?'
data$first_word[data$first_word == 'warm?'] <- 'what?'
data$first_word[data$first_word == 'why'] <- 'what?'
data$first_word[data$first_word == 'wholesome?'] <- 'wholesome'
data$first_word[data$first_word == 'worth'] <- 'worthiness'
data$first_word[data$first_word == 'corny '] <- 'corny'
data$first_word[data$first_word == 'pressure '] <- 'pressure'
data$first_word[data$first_word == 'reassurance '] <- 'reassurance'
data$first_word[data$first_word == 'relief '] <- 'relief'
data$first_word[data$first_word == 'sarcastic '] <- 'sarcastic'
data$first_word[data$first_word == 'stop '] <- 'stop'
data$first_word[data$first_word == 'stress'] <- 'stressed'
data$first_word[data$first_word == 'reassurance '] <- 'reassurance'
data$first_word[data$first_word == 'unncessary '] <- 'unnecessary'
data$first_word[data$first_word == 'mispelled'] <- 'misspelled'
first_words <- unique(data$first_word)
print(sort(first_words))

write.csv(data,"./data/prep-survey-response.csv")

# CLEAN MAJOR / MINOR COLUMNS