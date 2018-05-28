library (shiny)
library (plotly)

# Must change this \/
data <- read.csv ("../../data/prep-survey-response.csv")

grade.option <- c ("All", "First Year", "Second Year", "Third Year", "Fourth Year", 
                   "Fifth year", "Graduate")
major.option <- sort (unique (data$major))
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))

my.ui <- fluidPage (
  sidebarLayout (
    sidebarPanel (
      p ("Manipulate the data visualization by using the widgets below."),
      selectInput("grade", label = "Select a Grade Level", 
                  grade.option, selected = "All"),
      tags$strong ("Filter by Student's Ethnicity"), tags$br (),
      actionButton ("all.ethnicity", "Select/Deselect All"),
      checkboxGroupInput("ethnicity", label = "", 
                         choices = ethnicity.option, selected = ethnicity.option),
      tags$strong ("Select a Major"), tags$br (),
      actionButton ("all.major", "Select/Deselect All"),
      checkboxGroupInput("major", label = "", 
                         major.option, selected = major.option)
    ),
    mainPanel (
      h1 ("Percieved Effectiveness of Resilience Lab Signs"),
      tabsetPanel (
        tabPanel ("Frequency Count", 
                  h3 ("Response Frequency"),
                  p ("The bar graph above visualizes student's response to the question:"),
                  tags$ul (tags$li ("How effective do you believe the signs are at introducing 
                                    and promoting microcompassion on campus?")),
                  p ("This question evaluates the students perception of the effectiveness to
                     introduce or promote microcompassion on campus. Students answered on a 1 to 5
                     scale with 1 being not very effective and 5 being very effective."), 
                  plotlyOutput ("effective.plot")),
        tabPanel ("Correlation",
                  h3 ("Explore Correlations with Percieved Effectiveness of Signs"),
                  p ("Below visualizes the correlation between percieved effectiveness of
                     the signs and three different variables: rated mental health, experience
                     of microaggression, and experience of microcompassion.
                     To understand the x and y axis and the ratings see below:"), 
                  tags$ul (tags$li ("Effectiveness: 1 = Not Very Effective, 5 = Very Effective"), 
                           tags$li ("Mental Health: 1 = Poor, 5 = Excellent"), 
                           tags$li ("Experience Microaggression (relation to peers): 
                                    1 = Considerably Less, 5 =  Considerably More"),
                           tags$li ("Experience Microcompassion (relation to peers): 
                                    1 = Considerably Less, 5 = Considerably More")),
                  selectInput ("correlation.var", "Please choose a variable to analyze the 
                               correlation with percieved effectiveness:",
                               choices = c ("Mental Health", "Experience Microagression",
                                            "Experience Microcompassion")),
                  plotlyOutput ("effective.correlation")),
        tabPanel ("Analysis", h3 ("Analysis"))
                           )
    )
  )
)
