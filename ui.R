library (shiny)
library (plotly)
library (shinythemes)
library(knitr)

source("scripts/prep-data.R")
source("scripts/sentiment-analysis/first_word.R")

grade.option <- c ("All", "First Year", "Second Year", "Third Year", "Fourth Year", 
                   "Fifth year", "Graduate")
major.option <- sort (unique (data$major))
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.selection <- c ("Custom", "Competitive", "Open", "Minimum")
competitive.major <- c ("")
noncompetitive.major <- c ("")
minimum.major <- c ("")

my.ui <- fluidPage (theme = shinytheme ("sandstone"),
                    tags$head(
                      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
                    ),
                    navbarPage (p (tags$img (id = "sign-home", src = "resilience.png", width = 30), "UW Resilience Signs"),
                                
                                tabPanel ("Home",
                                          tags$div (id = "home-page",
                                                    h1 ("Introduction"), 
                                                    p ("\tThe UW Resilience Lab is a research program whose mission is 
                                     \"to bring the UW community into connection with one another through 
                                     programming that normalizes the wide-ranging experiences of hardship, 
                                     failures, and setbacks our community members face through the cultivation 
                                     of kindness, compassion, and gratitude toward each other and ourselves\" [1].
                                     They have implemented several small interventions on the University of Washington's campus to achieve
                                     their mission, such as Fail Forward Panels, the Failure and Gratitude Wall,
                                     and more."), 
                                                    p ("(To find out more about this research program:", 
                                                       tags$a (href = "http://webster.uaa.washington.edu/resilience/content-areas/what-we-do/", 
                                                               "Click Here"), ")"),
                                                    p ("\nThis shiny application focuses on one of the Resilience Lab's intervention, specifically the
                                     UW Resilience lab's signs that were distributed throughout campus at the start of
                                     Winter quarter 2018 and the beginning of Spring quarter 2018."),
                                                    h1 ("Project Background"),
                                                    tags$img (class = "sign", src = "sign-1.JPG", width = 300),
                                                    tags$img (class = "sign", src = "sign-2.JPG", width = 300),
                                                    tags$img (class = "sign", src = "sign-3.JPG", width = 300),
                                                    tags$img (class = "sign", src = "sign-4.JPG", width = 300),
                                                    p ("The UW Resilience Lab's signs were a project based on the \"Don't Give Up Signs Movement.\"
                                     Similarly, the movement distributed signs that communicated hopeful and reassuring messages
                                     to individuals throughout a community to spread hope and love. Most of the messages that
                                     were distributed on the university campus were used in the movement as well, such as \"You Matter,\" and
                                     and \"You are Worthy of Love.\" Additionally, there were messages unique to the campus that were
                                     displayed as well, such as \"The Cherry Blossom are coming\", and \"The days are getting longer.\"
                                     The UW Resilience lab's sign project was aimed toward promoting compassion on campus and was aimed as a way to
                                     combat microaggression with microcompassion. To financially implement this project, there was a $600 cost;
                                     each poster cost $20, and 30 signs were distributed on campus. The UW Resilience lab hopes to continue this
                                     project in the future with different messages."),
                                                    h1 ("Purpose"),
                                                    p ("This research project aims to determine the effectiveness of the UW Resilience Lab's Sign Project, \"to promote
                                     microcompassion and to combat microaggression.\" Our research group originally became intrigued to 
                                     conduct this study due to the student's general reponse to the signs. The signs triggered
                                     the creation of several memes on the \"UW Teens for Boundless Memes \" Facebook page which has 21,631 members
                                     though not all are UW students. The meme creation denoted a perception of the signs as sarcastic.
                                     Though there was an obvious purpose to the distribution and implemention of this signs project, thus we decided
                                     to delve deeper into the purpose of the signs and determine its effectiveness of its intentional
                                     purpose. We want to be able to draw relationships between student demographics/profiles and perception of the signs. 
                                     We also want to provide a resource for the Resilience Lab to use as a way to gain insight regarding their intervention, 
                                     and ultimately to help them in their decision of continuing this intervention in the future."),
                                                    h1 ("Related Works"),
                                                    p (""))
                                ),
                                tabPanel ("Methods",
                                          uiOutput("methods_tab")
                                ),
                                
                                tabPanel ("Mental Health",
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
                                          ),
                                
                                tabPanel ("Microagg. & Microcomp.",
                                          # Application title
                                          titlePanel("Mental Health and Perception of Microexperiences"),
                                          
                                          # Sidebar with a slider input for number of bins 
                                          sidebarLayout(
                                            sidebarPanel(
                                              # sliderInput("rating.health",
                                              #             label = h4("Rating of Mental Health (Poor(1) to Excellent(5))"),
                                              #             min = 1,
                                              #             max = 5,
                                              #             value = 3),
                                              
                                              checkboxGroupInput("rating.health",
                                                                 label = h4("Rating of Own Mental Health"),
                                                                 choices = list("Poor" = 1,
                                                                                "Kinda Poor" = 2,
                                                                                "Average" = 3,
                                                                                "Kinda Excellent" = 4,
                                                                                "Excellent" = 5),
                                                                 selected = 3),
                                              
                                              radioButtons("experience", 
                                                           label = h4("Microexperience"), 
                                                           choices = list("Microaggressions" = "microaggression",
                                                                          "Microcompassions" = "microcompassion", 
                                                                          "Both" = "both"), 
                                                           selected = "both")
                                            ),
                                            
                                            # Show a plot of the generated .. thing
                                            mainPanel(
                                              plotOutput("plotly"),
                                              p("This visualization shows our survey takers' rating of own their own mental health (1 being poor and 5 being excellent) versus their perception of how much microaggression and microcompassion they believe they experience relative to their peers."),
                                              tags$br(),
                                               p("Regarding experience with microaggressions, responses seem very spread out and does not seem to have a discernable trend."),
                                              tags$br(),
                                               p("Regarding experience with microcompassions, responses are clustered towards higher perceptions of microexperiences/experiencing relatively more microcompassions than their peers. This could mean that our survey takers are more optimistic in terms of how much kindness they receive relative to their peers (our microcompassions question is framed in terms of how much relative kindness they receive). Further, none of the students who answered 1 or 2 for the microcompassion question/believe they experience less kindness than their peers rate their mental health as excellent. ")
                                            )
                                            
                                          )),
                                
                                tabPanel ("Sentiment",
                                          # Application title
                                          titlePanel("First Word Sentiment Analysis"),
                                          
                                          # Sidebar with a slider input for number of bins 
                                          sidebarLayout(
                                            sidebarPanel(
                                              sliderInput("freq_slider", label = h3("Min Frequency"), min = 0, 
                                                          max = 5, value = 0),
                                              radioButtons("magnitude_bool", label = h3("Multiply Sentiment by Magnitude"),
                                                           choices = list("True" = TRUE, "False" = FALSE), 
                                                           selected = TRUE),
                                              h3(textOutput("sentimentDescription"))
                                            ),
                                            
                                            
                                            # Show a plot of the generated distribution
                                            mainPanel(
                                              plotlyOutput("sentimentPlot"),
                                              tags$br(),
                                              p("This application was created using the Google Natural Language processor and a list of the first word everyone surveyed thought of when seeing a Resilience Lab sign. Sentiment scores closer to 1 have very positive connotations, and sentiment scores closer to -1 have very negative connotations."),
                                              tags$br(),
                                              p("The average value is often very close to 0 in this case, which means that the on average, people did not have a strong positive or negative response to the signs."),
                                              wordcloud2Output("wordCloud")
                                            )
                                          )
                                ),
                                
                                tabPanel ("Effectiveness", 
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
                                ),
                                
                                tabPanel ("Behavior", 
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
                                           general. The link question was asked to discover __"),
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
                                           it brought about a way to release momentarily the stress the students were experiencing in their everyday life."),
                                                          h4 ("Behavior Change"),
                                                          p ("There were two major behavior changes individuals reported in response to the exposure
                                           of the signs: a change in attitude or reflection"))
                                              )
                                            )
                                          )
                                ),
                                
                                tabPanel ("Conclusions",
                                          uiOutput("conclusion_tab")
                                          
                                )
                    )
)

# Word Cloud