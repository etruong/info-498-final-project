// Imports the Google Cloud client library
let language = require("@google-cloud/language");
let fs = require("fs");

// Frequencies from R script
let frequencies = require("./frequencies.json");

// Instantiates a client
let client = new language.LanguageServiceClient();

let sentiments = {};

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

      sentiments[wordObj.first_word] = {
        frequency: wordObj.freq,
        sentiment: sentiment.score,
        magnitude: sentiment.magnitude
      };

      // Writes to a new JSON file every time because I'm bad at async
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
