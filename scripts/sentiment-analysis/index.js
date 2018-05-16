// Imports the Google Cloud client library
let language = require("@google-cloud/language");

// Instantiates a client
let client = new language.LanguageServiceClient();

// The text to analyze
let text = "Busy";

let document = {
  content: text,
  type: "PLAIN_TEXT"
};

// Detects the sentiment of the text
client
  .analyzeSentiment({ document: document })
  .then(results => {
    let sentiment = results[0].documentSentiment;

    console.log(`Text: ${text}`);
    console.log(`Sentiment score: ${sentiment.score}`);
    console.log(`Sentiment magnitude: ${sentiment.magnitude}`);
  })
  .catch(err => {
    console.error("ERROR:", err);
  });
