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
        tabPanel("Graphs", plotlyOutput("mental_health_uplift")),
        tabPanel("Tool", tags$br(), p("This tool allows one to look at the correlation between any two ordinal variables. If the two variables are the same, then a bar chart showing distributions of each answer appears.  tags$br()Results are filterable on major and year in school.  tags$br()Results are split between where the respondant discovered the signs.")),
        tabPanel("Analysis", p(""))
      )
    )
  )
)
