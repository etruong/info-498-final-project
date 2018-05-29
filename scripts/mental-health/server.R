#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# setwd("~/Desktop/Classes/INFO_498/wb-8-kasfranco/MentalHealthAndMicroExperiences")
library(shiny)
library (plotly)
source("data/mental-health/analysis.R")

shinyServer(function(input, output) {
  
  # filtered_data <- reactive ({
  #   if(input$experience != "both") {
  #     gathered_data <- filter(gathered_data, microexperience == input$experience)  
  #   } 
  #   gathered_data <- filter(gathered_data, ment.health == input$rating.health)
  #   return(gathered_data)
  # })
  
  filtered_data <- reactive ({
    shiny::validate (
      need (!is.null(input$rating.health), "Please select data")
    )
    if(input$experience != "both" & 
       (input$rating.health == 1 | input$rating.health == 2 |
        input$rating.health == 3 | input$rating.health == 4 |
        input$rating.health == 5)) {
      gathered_data <- filter(gathered_data, microexperience == input$experience) %>% 
                       filter(rating == input$rating.health)
    }
    gathered_data <- filter(gathered_data, ment.health == input$rating.health)
    return(gathered_data)
  })
  
  output$plot <- renderPlot({
    plot <- ggplot (filtered_data(), aes(x = ment.health, y = rating, col = microexperience)) +
      geom_jitter() +  #height = 0.3, width = 0.3
      labs(x = "Rating of Own Mental Health (Poor: 1, Excellent: 5)",
           y = "Perception of Microexperience (Relatively Less: 1, Relatively More: 5)",
           col = "Microexperience, Relative to Peers") + 
      xlim(0.5, 5.5) + ylim(0.5, 5.5)
    return(plot)
  })
  
})
