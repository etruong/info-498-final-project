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
        tabPanel ("Analysis",
                  h3 ("Analysis"),
                  p ("For the most part, individuals, regardless of race or grade level, are
                     reporting that the effectiveness of the signs are either ineffective or
                     neither ineffective/effective. Although when analyzing the data based on
                     the major students pursued, there are interesting results. STEM majors
                     are reporting more that the signs are ineffective than those who are
                     not STEM majors who are mainly reporting that the sign intervention were
                     neither ineffective/effective. We wanted to analyze the two different
                     major categories (STEM vs Non-STEM) because each major category covers different
                     topics and have differing demands of their students. Though these results
                     are likely skewed by our sample size. There are less Non-STEM major individuals
                     taking our survey than STEM majors taking our survey. Due to this, we
                     cannot have conclusive results."),
                  p ("When analyzing the variables correlated with the percieved effectiveness
                     of the signs, there was not a correlation between the microcompassion, 
                     microaggression, and mental health variables with percieved effectiveness.
                     This means that how much microcompassion or microaggression students experienced
                     (in relation to their peers) is not related with how effective they percieved the
                     signs as well as how they rated their mental health. This was not what we expected.
                     We predicted a plausible outcome would be that the higher an individual rated
                     their experience with microaggression the higher they rated for percieved effectiveness
                     of the signs. We also predicted that the lower a person rated their mental health,
                     they would percieve the signs as effective. We predicted this because in both cases, 
                     each individual are in vulnerable states, thus they would possibly be impacted by
                     the signs more. This was not that case."),
                  p ("A plausible reasoning for this outcome is likely due to the fact that the data
                     is mainly self-reported. Students may be basing their mental health on the current
                     state that they were in while taking the survey. The question about mental health 
                     aimed to attain data on surveyor's general mental health state. This may explain
                     the lack of correlation between the percieved effectiveness of signs and mental health."))
        )
      )
    )
  )

