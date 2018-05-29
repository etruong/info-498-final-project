library(shiny)
library(plotly)
library(wordcloud2)

source("../prep-data.R")
source("../sentiment-analysis/first_word.R")

shinyServer(function(input, output) {
  output$wordCloud <- renderWordcloud2(wordCloud)
  output$sentimentPlot <- renderPlotly(sentimentPlot())
  
  output$sentimentDescription <- renderText(sentimentDescription())
  
  sentimentDescription <- reactive({
    getDescription(input$freq_slider, input$magnitude_bool)
  })
  
  sentimentPlot <- reactive({
    getFilteredPlot(input$freq_slider, input$magnitude_bool)
  })
})
