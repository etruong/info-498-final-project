library (shiny)
library (ggplot2)
library (dplyr)
library (plotly)
library(alluvial)
library (tidyr)
library (shinythemes)
library(knitr)
if(!require(data.table)){install.packages("data.table");require(data.table)}

source("scripts/prep-data.R")
source("scripts/sentiment-analysis/first_word.R")
source("scripts/mental-health/analysis.R")

ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.option <- sort (unique (data$major))

qualitative.data <-
  read.csv ("data/qualitative-data.csv", stringsAsFactors = FALSE)

server <- function (input, output, session) {
  ##################
  # Markdown Files #
  ##################
  output$methods_tab <- renderUI({
    HTML(markdown::markdownToHTML(knit('scripts/methods-tab/methods_tab.Rmd', quiet = TRUE)))
  })
  
  # EFFECTIVENSS #
  ################
  filter.data <- reactive ({
    if (input$grade == "All") {
      return (filter (
        data,
        major %in% input$major & ethnicity %in% input$ethnicity
      ))
    } else {
      return (
        filter (
          data,
          school %in% input$grade & major %in% input$major &
            ethnicity %in% input$ethnicity
        )
      )
    }
  })
  
  observe({
    if (input$all.ethnicity == 0) {
      return(NULL)
    } else if (input$all.ethnicity %% 2 == 1) {
      updateCheckboxGroupInput(session, "ethnicity", "", choices = ethnicity.option)
    } else {
      # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,
                               "ethnicity",
                               "",
                               choices = ethnicity.option,
                               selected = ethnicity.option)
    }
  })
  
  observe({
    if (input$all.major == 0) {
      return(NULL)
    } else if (input$all.major %% 2 == 1) {
      updateCheckboxGroupInput(session, "major", "", choices = major.option)
    } else {
      # input$all.ethnicity%%2 == 0
      updateCheckboxGroupInput(session,
                               "major",
                               "",
                               choices = major.option,
                               selected = major.option)
    }
  })
  
  output$effective.plot <- renderPlotly ({
    p <- ggplot (filter.data()) +
      geom_bar (mapping = aes (x = effective, fill = school)) +
      guides(fill = guide_legend(title = "Grade Level")) +
      xlab ("Effectiveness") + xlim (0.5, 5.5)
    return (ggplotly (p))
  })
  
  output$effective.correlation <- renderPlotly ({
    effective.cor.graph <- ggplot (data = filter.data ()) +
      geom_jitter (
        mapping = aes (x = effective, y = mental_health),
        width = 0.10,
        color = "steelblue"
      ) +
      ggtitle ("Correlation Between Percieved Effectiveness of Signs and Mental Health") +
      xlab ("Rated Effectiveness of Signs") + ylab ("Mental Health") + ylim (0.5, 5.5)
    if (input$correlation.var == "Experience Microagression") {
      effective.cor.graph <- ggplot (data = filter.data ()) +
        geom_jitter (
          mapping = aes (x = effective, y = microaggression),
          width = 0.10,
          color = "steelblue"
        ) +
        ggtitle (
          "Correlation Between Percieved Effectiveness of Signs and Experience of Microaggression"
        )  +
        xlab ("Rated Effectiveness of Signs") + ylab ("Experience with Microaggression") + ylim (0.5, 5.5)
    } else if (input$correlation.var == "Experience Microcompassion") {
      effective.cor.graph <- ggplot (data = filter.data ()) +
        geom_jitter (
          mapping = aes (x = effective, y = microcompassion, color = microcompassion),
          width = 0.10,
          color = "steelblue"
        ) +
        ggtitle (
          "Correlation Between Percieved Effectiveness of Signs and Experience of Microcompassion"
        )  +
        xlab ("Rated Effectiveness of Signs") + ylab ("Experience with Microcompassion") + ylim (0.5, 5.5)
    }
    return (ggplotly (effective.cor.graph))
  })
  
  output$effective.cor.var <- renderText ({
    return (input$correlation.var)
  })
  
  ###################
  # BEHAVIOR CHANGE #
  ###################
  
  observe ({
    if (input$answer == "All") {
      updateRadioButtons (session,
                          "view",
                          choices = "None",
                          selected = "None")
    } else {
      # input$answer != "All"
      updateRadioButtons (
        session,
        "view",
        choices = c ("Ethnicity", "Major",
                     "Grade Level", "None"),
        selected = input$view
      )
    }
  })
  
  behavior.data <- reactive ({
    behavior.data <-
      select (
        data,
        gender,
        ethnicity,
        age,
        school,
        major,
        mental_health,
        link,
        behavior_change,
        talk_sign
      )
    behavior.data <-
      gather (behavior.data, question, answer, link:talk_sign)
    behavior.data <- filter (behavior.data, answer != "")
    if (input$answer == "Yes" |
        input$answer == "No" | input$answer == "Unsure") {
      behavior.data <- filter (behavior.data, answer == input$answer)
    }
    return (behavior.data)
  })
  
  output$behavior.chart <- renderPlotly ({
    if (input$view == "Ethnicity") {
      ggplotly(
        ggplot (data = behavior.data()) +
          geom_bar (
            mapping = aes (x = question, fill = ethnicity),
            position = "stack"
          ) +
          ggtitle ("Exposure to Sign & Behavior Change Bar Graph")
      )
    } else if (input$view == "Major") {
      ggplotly(
        ggplot (data = behavior.data()) +
          geom_bar (
            mapping = aes (x = question, fill = major),
            position = "stack"
          ) +
          ggtitle ("Exposure to Sign & Behavior Change Bar Graph")
      )
    } else if (input$view == "Grade Level") {
      ggplotly(
        ggplot (data = behavior.data()) +
          geom_bar (
            mapping = aes (x = question, fill = school),
            position = "stack"
          ) +
          ggtitle ("Exposure to Sign & Behavior Change Bar Graph")
      )
    } else {
      if (input$view == "None" & input$answer != "All") {
        ggplotly(
          ggplot (data = behavior.data()) +
            geom_bar (
              mapping = aes (x = question, fill = answer),
              position = "dodge"
            ) +
            ggtitle ("Exposure to Sign & Behavior Change Bar Graph") +
            theme (legend.position = "none")
        )
      } else {
        ggplotly(
          ggplot (data = behavior.data()) +
            geom_bar (
              mapping = aes (x = question, fill = answer),
              position = "dodge"
            ) +
            ggtitle ("Exposure to Sign & Behavior Change Bar Graph")
        )
      }
    }
    
  })
  
  output$explain.talk <- renderTable ({
    Sys.setlocale('LC_ALL', 'C')
    talk.explain <-
      select (
        qualitative.data,
        talk.memes,
        talk.negative,
        talk.positive,
        talk.both,
        talk.funny,
        talk.neutral
      )
    talk.explain <-
      gather (talk.explain,
              category,
              explanation,
              talk.memes:talk.neutral)
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
    Sys.setlocale('LC_ALL', 'C')
    behavior.explain <-
      select (
        qualitative.data,
        behavior.attitude,
        behavior.reminder,
        behavior.smile,
        behavior.negative
      )
    behavior.explain <-
      gather (behavior.explain,
              category,
              explanation,
              behavior.attitude:behavior.negative)
    behavior.explain <- filter (behavior.explain, explanation != "")
    if (input$behavior.category != "All") {
      if (input$behavior.category == "Attitude") {
        behavior.explain <-
          filter (behavior.explain, category == "behavior.attitude")
      } else if (input$behavior.category == "Reminder") {
        behavior.explain <-
          filter (behavior.explain, category == "behavior.reminder")
      } else if (input$behavior.category == "Negative") {
        behavior.explain <-
          filter (behavior.explain, category == "behavior.negative")
      }
      behavior.explain <- select (behavior.explain, explanation)
    }
    return (behavior.explain)
  })
  
  #################
  # Mental Health #
  #################
  filtered_data_mental <- reactive ({
    shiny::validate (need (!is.null(input$rating.health), "Please select data"))
    if (input$experience != "both" &
        (
          input$rating.health == 1 | input$rating.health == 2 |
          input$rating.health == 3 | input$rating.health == 4 |
          input$rating.health == 5
        )) {
      gathered_data <- filter(gathered_data, microexperience == input$experience) %>%
        filter(rating == input$rating.health)
    }
    gathered_data <- filter(gathered_data, ment.health == input$rating.health)
    
    return(gathered_data)
  })
  
  output$plotly <- renderPlot({
    plot <-
      ggplot (filtered_data_mental(),
              aes(x = ment.health, y = rating, col = microexperience)) +
      geom_jitter() +  #height = 0.3, width = 0.3
      labs(x = "Rating of Own Mental Health (Poor(1) to Excellent(5))",
           y = "Perception of Microexperience (Relatively Less(1) to Relatively More(5))",
           col = "Microexperience, Relative to Peers") #+
    #xlim(0.5, 5.5) + ylim(0.5, 5.5)
    return(plot)
  })
  
  ######################
  # Sentiment Analysis #
  ######################
  
  output$wordCloud <- renderWordcloud2(wordCloud)
  output$sentimentPlot <- renderPlotly(sentimentPlot())
  
  output$sentimentDescription <- renderText(sentimentDescription())
  
  sentimentDescription <- reactive({
    getDescription(input$freq_slider, input$magnitude_bool)
  })
  
  sentimentPlot <- reactive({
    getFilteredPlot(input$freq_slider, input$magnitude_bool)
  })
  
  ####################
  # Jared's whatever #
  ####################
  
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
                                                                         position = "stack",aes(fill = location_see)) + xlim(0.5,5.5)
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
