#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
if(!require(data.table)){install.packages("data.table");require(data.table)}
if(!require(tidyr)){install.packages("tidyr");require(tidyr)}
if(!require(ggplot2)){install.packages("ggplot2");require(ggplot2)}
library(plotly)

# Define UI for application that draws a histogram
# my.ui <- fluidPage(
# 
#   # Application title
#   titlePanel("Mental Health and Personal Uplifting Effect"),
# 
#   # Sidebar with a slider input for number of bins
#   sidebarLayout(
#     sidebarPanel(
#       checkboxGroupInput("year", # server id
#                    "Year:", # name
#                    choices = c('First Year','Second Year','Third Year','Fourth Year','Fifth Year','Graduate'),
#                    selected = c('First Year','Second Year','Third Year','Fourth Year','Fifth Year','Graduate')),
#        selectInput("major",
#                    "Major",
#                    choices=c("All", "Informatics", "Computer Science & Engineering", "Business Administration", "Biochemistry", "Philosophy", "Economics", "Statistics", "Physics", "Civil Engineering", "Chemical Engineering", "Anthropology: Medical Anth & Global Hlth", "Education", "Industrial Design", "Sociology", "Psychology", "Undecided", "Electrical Engineering", "Mechanical Engineering", "Biology", "Spanish", "Public Health", "English", "Geography", "International Studies", "Accounting", "Human-Centered Design & Engineering", "Geophysics", "Pre Nursing", "Neuroscience", "Aquatic and Fishery Sciences", "Bioengineering", "Speech and Hearing Sciences", "Neurobiology", "Marketing", "Mathematics", "Communication", "Law, Societies, and Justice", "Aeronautics & Astronautics", "Political Science"))
#     ),
# 
#     # Show a plot of the generated distribution
#     mainPanel(
#        plotlyOutput("mental_health_uplift")
#     )
#   )
# )


my.ui <- fluidPage(
  titlePanel("Mental Health and Personal Uplifting Effect"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("year", # server id
                         "Year:", # name
                         choices = c('First Year','Second Year','Third Year','Fourth Year','Fifth Year','Graduate'),
                         selected = c('First Year','Second Year','Third Year','Fourth Year','Fifth Year','Graduate')),
      selectInput("major",
                  "Major:",
                  choices=c("All", "Informatics", "Computer Science & Engineering", "Business Administration", "Biochemistry", "Philosophy", "Economics", "Statistics", "Physics", "Civil Engineering", "Chemical Engineering", "Anthropology: Medical Anth & Global Hlth", "Education", "Industrial Design", "Sociology", "Psychology", "Undecided", "Electrical Engineering", "Mechanical Engineering", "Biology", "Spanish", "Public Health", "English", "Geography", "International Studies", "Accounting", "Human-Centered Design & Engineering", "Geophysics", "Pre Nursing", "Neuroscience", "Aquatic and Fishery Sciences", "Bioengineering", "Speech and Hearing Sciences", "Neurobiology", "Marketing", "Mathematics", "Communication", "Law, Societies, and Justice", "Aeronautics & Astronautics", "Political Science")),
      radioButtons("trait1",
                   label = "X-Axis Trait:",
                   choices = list("Mental Health" = "mental_health", "Microagression" = "microaggression",
                                  "Microcompassion" = "microcompassion", "Uplift" = "uplift",
                                  "Discouragement" = "discourage", "Effectiveness" = "effective"),
                   selected = "uplift"),
      # Choose trait two
      radioButtons("trait2",
                   label = "Y-Axis Trait:",
                   choices = list("Mental Health" = "mental_health", "Microagression" = "microaggression",
                                  "Microcompassion" = "microcompassion", "Uplift" = "uplift",
                                  "Discouragement" = "discourage", "Effectiveness" = "effective"),
                   selected = "mental_health")
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Graphs", plotlyOutput("mental_health_uplift"),
                 tags$br(), 
                 p("This tool allows one to look at the relationship between any two ordinal variables."),
                 tags$br(),
                 p("If the two variables are the same, then a bar chart showing distributions of each answer appears."),
                 tags$br(),
                 p("Results are filterable on major and year in school."),
                 tags$br(),
                 p("Results are split between where the respondant discovered the signs.")),
        tabPanel("Analysis", 
                 tags$br(),
                 p("Diving into the various relationships between variables shows some interesting patterns in how students perceive the Resilience signs.  All observations noted were taken when considering the entire student population, because looking at subsets of the data by filtering year or major reduced the sample size by too much. However, when considering the entire population these patterns emerge:"),
                 tags$br(),
                 tags$li("People who report higher mental health typically see more microcompassions."),
                 tags$li("People who report higher mental health typically see more microaggressions."),
                 tags$li("Most people report seeing few microaggressions."),
                 tags$br(),
                 p("These three observations show that people with higher mental health may be more aware of their community and the impact of small actions towards groups."),
                 tags$br(),
                 tags$li("People who see more microcompassions see less microaggressions and vice versa"),
                 tags$br(),
                 p("This observation shows that the power of positive thinking/observation may protect groups."),
                 tags$br(),
                 tags$li("People who see more microagressions perceived the signs as uplifting."),
                 tags$li("People who see more microcompassions tend to see higher effectiveness."),
                 tags$li("If the signs were uplifting they were more likely to be perceived as effective."),
                 tags$br(),
                 p("These two observations show that the signs are an effective way to reaching those affected by microaggressions, and that those who view the signs as positive have a better outlook on their community.
"))
      )
    )
  )
)
