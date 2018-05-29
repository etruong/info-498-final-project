# Sentiment-Analysis
##How to use
1. Create or select a project in the [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the Google Natural Language API for that project.
3. Create a service account.
4. Download a private key as JSON.
5. Configure the Google credentials with: `$ export GOOGLE_APPLICATION_CREDENTIALS="[PATH OF CREDENTIAL JSON]"`
6. Run with `$ npm start`

Note that this app is very poorly made and will not work with any other projects outside of the info 498 final project. It's probably best to never run it outside of the R script in this app's containing folder! 😬