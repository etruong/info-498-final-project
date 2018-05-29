library (shiny)
library (plotly)
library (shinythemes)

# Change this \/
data <- read.csv ("../../data/prep-survey-response.csv")

grade.option <- c ("All", "First Year", "Second Year", "Third Year", "Fourth Year", 
                   "Fifth year", "Graduate")
major.option <- sort (unique (data$major))
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))

my.ui <- fluidPage (
  sidebarLayout (
    sidebarPanel (
      p ("Manipulate the data visualization by using the widgets below."),
      radioButtons ("answer", label = "Select Answer to Questions",
                    choices = c ("Yes", "No", "Unsure", "All"),
                    selected = "All"),
      radioButtons ("view", label = "View bar chart by:",
                    choices = c ("Ethnicity", "Major", "Grade Level", "None"),
                    selected = "None")
    ),
    mainPanel (
      h1 ("Behavior Change"),
      tabsetPanel (
        tabPanel ("Behavior Chart", 
                  h3 ("Behavior"),
                  p ("The chart below visualizes respondents' answers to the following three survey questions:"),
                  tags$ol (tags$li ("Do you think your behavior changed because of the signs?", tags$em ("(behavior_change)")),
                           tags$li ("Have you talked to others about the signs?", tags$em ("(talk_sign)")),
                           tags$li ("Did you go to the link on the signs?", tags$em ("(link)"))),
                  p ("In addition to students' quantitative binary answers, qualitative data detailing more
                     in-depth about what the students discussed or how their behavior was changed was attained
                     and documented in the \"in-depth\" section."),
                  plotlyOutput ("behavior.chart")),
        tabPanel ("Discussion", h3 ("Discussion about Signs"), p ("The table below goes into more detail about
                                                                  what specifically was talked about when individuals answered
                                                                  \"Yes\" to the question: \"Have you talked about the signs?\"
                                                                  The answers are qualitatively coded according to the subjects
                                                                  that were discussed."),
                  selectInput ("talk.category", "Select a Category", choices = c ("All", "Memes", "Positive", 
                                                                                  "Negative", "Both Positive/Negative", 
                                                                                  "Funny", "Neutral")),
                  tableOutput ("explain.talk")),
        tabPanel ("Specific Behavior Change", h3 ("Specific Behavior Change"), p ("The table below goes into more detail about
                                                                                  what specifically the specific behavior changes individual's 
                                                                                  experience after answering \"Yes\" to the question: \"Do you 
                                                                                  think your behavior changed beause of the signs?\" The answers 
                                                                                  are qualitatively coded according to the subjects that were discussed."),
                  selectInput ("behavior.category", "Select a Category", choices = c ("All", "Attitude", "Reminder", "Negative")),
                  tableOutput ("explain.behavior")),
        tabPanel ("Analysis", h3 ("Analysis"),
                  h4 ("General Results"),
                  p ("When attaining data on individual's response to the UW Resilience signs, we also
                     asked whether or not their behavior was impacted at all.
                     A change could be as minimal as a shift in mood or as simple as expressing a smile
                     toward another individual because of their shift in attitude. Behavior also encompasses
                     initiating in a specific action such as talking to others about the signs or looking up
                     the link that were displayed on the signs to discover what the intervention is about.
                     In attaining this information, we wanted to see if the signs initiated a discussion
                     about microaggression/microcompassion on campus and the changes it brought to people in
                     general. The link question was asked to discover whether students discovered
                     the UW Resilience Lab and pausibly become more involved and initiated connection with
                     others."),
                  p ("In all three questions, a majority of the individuals said \"No.\"
                     This indicates that a majority of individual's behavior were not impacted by the
                     sign intervention. Though the highest question that individuals responded \"Yes\" to
                     pertained to discussing about the signs; 31 individuals responded \"Yes.\" On the
                     other hand, only 7 out of the 150 individuals who answered said \"Yes for the 
                     link question, and only 12 responded \"Yes\" for the behavior change. In our
                     survey, we followed up the behavior change and talk question with a short response
                     prompting individuals to detail what was discussed or what behavior change occured."),
                  h4 ("Sign Discussion"),
                  p ("For the discussion of the signs question, the individuals who talked about the signs
                     mainly talked about it in a negative or satirical manner. One interesting response
                     an individual had mentioned how it was positive yet triggered a negative part of
                     her experience at the university. This is interesting because the purpose
                     of the signs were to spread compassion on campus, yet instead it grew to be a \"trigger\"
                     for the students instead."),
                  p ("Students also discussed the signs in a satirical manner, more specifically they talked about
                     the memes of the signs and the hilarity of them in general. While the topics of the signs discussed 
                     was not the intention of the UW Resilience signs, it is possible that the signs allowed students a
                     topic to bond over and triggered this shared discussion of misery or college struggle. We argue that 
                     it brought about a way to release momentarily the stress the students were experiencing in their everyday life.
                     Though more research is required to back up this assumption."),
                  h4 ("Behavior Change"),
                  p ("There were two major topics individuals reported in response to the exposure
                     of the signs changing their behavior: students mentioned a change in attitude or 
                     the signs being a reminder to them. The change in attitude was the expected and 
                     intentional aspect of this intervention; the UW resilience lab wanted to spread compassion
                     on campus, and this would alter individual's attitude from negative to positive Although the signs
                     as a reminder is interesting because this was not the intention of the UW resilience lab signs. It
                     reminded students of the bigger picture, to stop worrying, and more importantly changed individual's
                     mindset. This is likely because constant exposure to positive messages may change someone's negative
                     outlook."))
                  )
                  )
        )
)