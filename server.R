library (shiny)
library (ggplot2)
library (dplyr)
library (plotly)
library(alluvial)
#install.packages ("alluvial")
library (tidyr)

data <- read.csv ("data/prep-survey-response.csv")
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.option <- sort (unique (data$major))

qualitative.data <- read.csv ("data/qualitative-data.csv", stringsAsFactors = FALSE)

server <- function (input, output, session) {
  ################
  # EFFECTIVENSS #
  ################
  
  filter.data <- reactive ({
    if (input$grade == "All") {
      return (filter (data, major %in% input$major & ethnicity %in% input$ethnicity))
    } else {
      return (filter (data, school %in% input$grade & major %in% input$major & ethnicity %in% input$ethnicity))
    }
  })
  
  observe({
    if(input$all.ethnicity == 0) {
      return(NULL) 
    } else if (input$all.ethnicity%%2 == 1) {
      updateCheckboxGroupInput(session,"ethnicity","", choices=ethnicity.option)
    } else { # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,"ethnicity","", choices=ethnicity.option, selected=ethnicity.option)
    }
  })
  
  observe({
    if(input$all.major == 0) {
      return(NULL) 
    } else if (input$all.major %% 2 == 1) {
      updateCheckboxGroupInput(session,"major","", choices=major.option)
    } else { # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,"major","", choices=major.option, selected=major.option)
    }
  })
  
  output$effective.plot <- renderPlotly ({
    p <- ggplot (filter.data()) +
      geom_bar (mapping = aes (x = effective, fill = school)) +
      guides(fill=guide_legend(title="Grade Level")) +
      xlab ("Effectiveness") + xlim (0.5, 5.5)
    return (ggplotly (p))
  })
  
  ###################
  # BEHAVIOR CHANGE #
  ###################
  
  observe ({
    if (input$answer == "All") {
      updateRadioButtons (session, "view", choices = "None", selected = "None")
    } else { # input$answer != "All"
      updateRadioButtons (session, "view", choices = c ("Ethnicity", "Major", "Grade Level", "None"), 
                          selected = input$view)
    }
  })
  
  behavior.data <- reactive ({
    behavior.data <- select (data, gender, ethnicity, age, school, major, mental_health, link, 
                             behavior_change, talk_sign)
    behavior.data <- gather (behavior.data, question, answer, link:talk_sign)
    behavior.data <- filter (behavior.data, answer != "")
    if (input$answer == "Yes" | input$answer == "No" | input$answer == "Unsure") {
      behavior.data <- filter (behavior.data, answer == input$answer)
    } 
    return (behavior.data)
  })
  
  output$behavior.chart <- renderPlotly ({
    if (input$view == "Ethnicity") {
      ggplotly(ggplot (data = behavior.data()) + 
                 geom_bar (mapping = aes (x = question, fill = ethnicity), position = "stack") +
                 ggtitle ("Exposure to Sign & Behavior Change Bar Graph"))
    } else if (input$view == "Major") {
      ggplotly(ggplot (data = behavior.data()) + 
                 geom_bar (mapping = aes (x = question, fill = major), position = "stack") +
                 ggtitle ("Exposure to Sign & Behavior Change Bar Graph")) 
    } else if (input$view == "Grade Level") {
      ggplotly(ggplot (data = behavior.data()) + 
                 geom_bar (mapping = aes (x = question, fill = school), position = "stack") +
                 ggtitle ("Exposure to Sign & Behavior Change Bar Graph"))
    } else {
      if (input$view == "None") {
        ggplotly(ggplot (data = behavior.data()) + 
                   geom_bar (mapping = aes (x = question, fill = answer), position = "dodge") +
                   ggtitle ("Exposure to Sign & Behavior Change Bar Graph") +
                   theme (legend.position = "none"))
      } else {
        
      }
    }
    
  })
  
  output$explain.talk <- renderTable ({
    talk.explain <- select (qualitative.data, talk.memes, talk.negative, talk.positive, talk.both,
                            talk.funny, talk.neutral)
  })
}
