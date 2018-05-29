library (shiny)
library (ggplot2)
library (dplyr)
library (plotly)
library (tidyr)

# Change this \/
data <- read.csv ("../../data/prep-survey-response.csv", stringsAsFactors = FALSE)
qualitative.data <- read.csv ("../../data/qualitative-data.csv", stringsAsFactors = FALSE)

ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.option <- sort (unique (data$major))

my.server <- function (input, output, session) {
  observe ({
    if (input$answer == "All") {
      updateRadioButtons (session, "view", choices = "None", selected = "None")
    } else { # input$answer != "All"
      updateRadioButtons (session, "view", choices = c ("Ethnicity", "Major", 
                                                        "Grade Level", "None"), selected = input$view)
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
      if (input$view == "None" & input$answer != "All") {
        ggplotly(ggplot (data = behavior.data()) + 
                   geom_bar (mapping = aes (x = question, fill = answer), position = "dodge") +
                   ggtitle ("Exposure to Sign & Behavior Change Bar Graph") +
                   theme (legend.position = "none"))
      } else {
        ggplotly(ggplot (data = behavior.data()) + 
                   geom_bar (mapping = aes (x = question, fill = answer), position = "dodge") +
                   ggtitle ("Exposure to Sign & Behavior Change Bar Graph"))
      }
    }
    
  })
  
  output$explain.talk <- renderTable ({
    Sys.setlocale('LC_ALL','C')
    talk.explain <- select (qualitative.data, talk.memes, talk.negative, talk.positive, talk.both,
                            talk.funny, talk.neutral)
    talk.explain <- gather (talk.explain, category, explanation, talk.memes:talk.neutral)
    talk.explain <- filter (talk.explain, explanation != "")
    if (input$talk.category != "All") {
      if (input$talk.category == "Memes") {
        talk.explain <- filter (talk.explain, category == "talk.memes")
      } else if (input$talk.category == "Positive") {
        talk.explain <- filter (talk.explain, category == "talk.positive")
      } else if (input$talk.category == "Negative") {
        talk.explain <- filter (talk.explain, category == "talk.negative")
      } else if (input$talk.category == "Both Positive/Negative") {
        talk.explain <- filter (talk.explain, category == "talk.both")
      } else if (input$talk.category == "Funny") {
        talk.explain <- filter (talk.explain, category == "talk.funny")
      } else if (input$talk.category == "Neutral") {
        talk.explain <- filter (talk.explain, category == "talk.neutral")
      }  
      talk.explain <- select (talk.explain, explanation)
    }
    return (talk.explain)
  })
  
  output$explain.behavior <- renderTable ({
    Sys.setlocale('LC_ALL','C')
    behavior.explain <- select (qualitative.data, behavior.attitude, behavior.reminder, behavior.smile, 
                                behavior.negative)
    behavior.explain <- gather (behavior.explain, category, explanation, behavior.attitude:behavior.negative)
    behavior.explain <- filter (behavior.explain, explanation != "")
    if (input$behavior.category != "All") {
      if (input$behavior.category == "Attitude") {
        behavior.explain <- filter (behavior.explain, category == "behavior.attitude")
      } else if (input$behavior.category == "Reminder") {
        behavior.explain <- filter (behavior.explain, category == "behavior.reminder")
      } else if (input$behavior.category == "Negative") {
        behavior.explain <- filter (behavior.explain, category == "behavior.negative")
      }
      behavior.explain <- select (behavior.explain, explanation)
    }
    return (behavior.explain)
  })
}