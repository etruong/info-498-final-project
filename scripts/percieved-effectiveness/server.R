library (shiny)
library (ggplot2)
library (dplyr)
library (plotly)
library (tidyr)
#install.packages("shinythemes")
library (shinythemes)

# Must change this \/
data <- read.csv ("../../data/prep-survey-response.csv", stringsAsFactors = FALSE)
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.option <- sort (unique (data$major))

qualitative.data <- read.csv ("../../data/qualitative-data.csv", stringsAsFactors = FALSE)

my.server <- function (input, output, session) {
  
  filter.data <- reactive ({
    if (input$grade == "All") {
      return (filter (data, major %in% input$major & ethnicity %in% input$ethnicity))
    } else {
      return (filter (data, school %in% input$grade & major %in% input$major & 
                        ethnicity %in% input$ethnicity))
    }
  })
  
  observe({
    if(input$all.ethnicity == 0) {
      return(NULL) 
    } else if (input$all.ethnicity%%2 == 1) {
      updateCheckboxGroupInput(session,"ethnicity","", choices=ethnicity.option)
    } else { # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,"ethnicity","", choices=ethnicity.option, 
                               selected=ethnicity.option)
    }
  })
  
  observe({
    if(input$all.major == 0) {
      return(NULL) 
    } else if (input$all.major %% 2 == 1) {
      updateCheckboxGroupInput(session,"major","", choices=major.option)
    } else { # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,"major","", choices=major.option, 
                               selected=major.option)
    }
  })
  
  output$effective.plot <- renderPlotly ({
    if (input$grade == "All") {
      p <- ggplot (filter.data()) +
        geom_bar (mapping = aes (x = effective, fill = school)) +
        guides(fill=guide_legend(title="Grade Level")) +
        xlab ("Effectiveness") + xlim (0.5, 5.5)
    } else { # input$grade != "All"
      p <- ggplot (filter.data()) +
        geom_bar (mapping = aes (x = effective), fill = "skyblue") +
        guides(fill=guide_legend(title="Grade Level")) +
        xlab ("Effectiveness") + xlim (0.5, 5.5)
    }
    return (ggplotly (p))
  })
  
  output$effective.correlation <- renderPlotly ({
    effective.cor.graph <- ggplot (data = filter.data ()) +
      geom_jitter (mapping = aes (x = effective, y = mental_health), width = 0.10, color = "steelblue") +
      ggtitle ("Correlation Between Percieved Effectiveness of Signs and Mental Health") +
      xlab ("Rated Effectiveness of Signs") + ylab ("Mental Health") + ylim (0.5, 5.5)
    if (input$correlation.var == "Experience Microagression") {
      effective.cor.graph <- ggplot (data = filter.data ()) +
        geom_jitter (mapping = aes (x = effective, y = microaggression), width = 0.10, color = "steelblue") +
        ggtitle ("Correlation Between Percieved Effectiveness of Signs and Experience of Microaggression")  +
        xlab ("Rated Effectiveness of Signs") + ylab ("Experience with Microaggression") + ylim (0.5, 5.5)
    } else if (input$correlation.var == "Experience Microcompassion") {
      effective.cor.graph <- ggplot (data = filter.data ()) +
        geom_jitter (mapping = aes (x = effective, y = microcompassion, color = microcompassion), width = 0.10, color = "steelblue") +
        ggtitle ("Correlation Between Percieved Effectiveness of Signs and Experience of Microcompassion")  +
        xlab ("Rated Effectiveness of Signs") + ylab ("Experience with Microcompassion") + ylim (0.5, 5.5)
    }
    return (ggplotly (effective.cor.graph))
  })
  
  output$effective.cor.var <- renderText ({
    return (input$correlation.var)
  })
}