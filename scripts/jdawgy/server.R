#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
if(!require(data.table)){install.packages("data.table");require(data.table)}
if(!require(tidyr)){install.packages("tidyr");require(tidyr)}
if(!require(ggplot2)){install.packages("ggplot2");require(ggplot2)}
library(plotly)
library(shiny)
source("../prep-data.R")
# data <- read.csv("./prep-survey-response.csv")
# Define server logic required to draw a scatterplot
server <- function(input, output) {
  returndata <- data
  filter.data <- reactive ({
    if(input$major == 'All'){
      returndata <- data
    } else {
      returndata <- (filter (data, major %in% input$major))  
    }
    if(is.null(input$year)){
      return (returndata)
    } else {
      return (filter (returndata, school %in% input$year ))
    }
    return (returndata)
  })
  
  output$mental_health_uplift <- renderPlotly({
    if (input$trait1 == input$trait2) {
      plot <- ggplot(filter.data(), aes_string(input$trait1)) + geom_bar(stat = "count",
               position = "stack",aes(fill = location_see))
      return(ggplotly(plot))
    } else {
      colNames <- unique(data$location_see)
      as.vector(levels(unique(data$location_see)))[unique(data$location_see)]
      p <- plotly::plot_ly()
      # xlab <- input$trait1 + ' Rating (5 is High)'
      xlab <- paste0(input$trait1, " Rating (1 to 5)")
      ylab <- paste0(input$trait2, " Rating (1 to 5)")
      titlelab <- paste0(input$trait1, " vs. ", input$trait2)
      # titlelab <- paste0(input$trait1, " vs. " + input$trait2)
      plot <- ggplot(filter.data(), aes_string(x=input$trait1, y=input$trait2, color="location_see")) +
        geom_point(size=2, shape=23) + geom_jitter(width=0.3) + xlim(0.5,5.5)+ylim(0.5,5.5) + 
        labs(x = xlab, y= ylab, title = titlelab)
        # theme(title=input$trait1)
       # xlab("Uplift Rating (5 is High)") + ylab("Mental Health Rating (5 is High") + ggtitle("Uplift vs Mental Health")
      return (ggplotly (plot))
    }
  })
}