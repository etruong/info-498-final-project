// Imports the Google Cloud client library
let language = require("@google-cloud/language");
let fs = require("fs");

// Frequencies from R script
let frequencies = require("./frequencies.json");

// Instantiates a client
let client = new language.LanguageServiceClient();

let sentiments = {
    first_word: [],
    freq: [],
    sentiment: [],
    magnitude: [],
};

// Gets sentiment analysis of all words
for (let wordObj of frequencies) {
  let document = {
    content: wordObj.first_word,
    type: "PLAIN_TEXT"
  };

  client
    .analyzeSentiment({ document: document })
    .then(results => {
      let sentiment = results[0].documentSentiment;

      console.log(`Text: ${wordObj.first_word}`);
      console.log(`Sentiment score: ${sentiment.score}`);
      console.log(`Sentiment magnitude: ${sentiment.magnitude}`);

      sentiments.first_word.push(wordObj.first_word);
      sentiments.freq.push(wordObj.freq);
      sentiments.sentiment.push(sentiment.score);
      sentiments.magnitude.push(sentiment.magnitude);

      // Writes to a new JSON file every time because I'm bad at async lol
      fs.writeFileSync(
        "data/frequencies_with_sentiment.json",
        JSON.stringify(sentiments),
        "utf8"
      );
    })
    .catch(err => {
      console.error("ERROR:", err);
    });
}
