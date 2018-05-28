#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#setwd("~/Desktop/Classes/INFO_498/wb-8-kasfranco/MentalHealthAndMicroExperiences")
library(shiny)
source("analysis.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mental Health and Perception of Microexperiences"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       # sliderInput("rating.health",
       #             label = h4("Rating of Mental Health (Poor(1) to Excellent(5))"),
       #             min = 1,
       #             max = 5,
       #             value = 3),
       
       checkboxGroupInput("rating.health",
                          label = h4("Rating of Own Mental Health"),
                          choices = list("Poor" = 1,
                                         "Kinda Poor" = 2,
                                         "Average" = 3,
                                         "Kinda Excellent" = 4,
                                         "Excellent" = 5),
                          selected = 3),
                          
       radioButtons("experience", 
                    label = h4("Microexperience"), 
                   choices = list("Microaggressions" = "microaggression",
                                  "Microcompassions" = "microcompassion", 
                                  "Both" = "both"), 
                   selected = "both")
    ),
    
    # Show a plot of the generated .. thing
    mainPanel(
       plotOutput("plotly")
    )
  )
))
