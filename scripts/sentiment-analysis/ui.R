#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(wordcloud2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("First Word Sentiment Analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("freq_slider", label = h3("Min Frequency"), min = 0, 
                  max = 5, value = 0),
      radioButtons("magnitude_bool", label = h3("Multiply Sentiment by Magnitude"),
                   choices = list("True" = TRUE, "False" = FALSE), 
                   selected = TRUE),
      h3(textOutput("sentimentDescription"))
    ),

    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("sentimentPlot"),
       wordcloud2Output("wordCloud")
    )
  )
))
