library (shiny)
data <- read.csv ("data/prep-survey-response.csv")

grade.option <- c ("All", "First Year", "Second Year", "Third Year", "Fourth Year", 
                   "Fifth year", "Graduate")
major.option <- sort (unique (data$major))
ethnicity.option <- sort (as.vector (unique (data$ethnicity)))
major.selection <- c ("Custom", "Competitive", "Open", "Minimum")
competitive.major <- c ("")
noncompetitive.major <- c ("")
minimum.major <- c ("")

my.ui <- fluidPage (
  
  navbarPage ("UW Resilience Signs",
              
              tabPanel ("Home",
                tags$img (src = "resilience.JPG", width = 300),
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
                   and ultimately to be able to inform whatever next steps they decide to take."),
                h1 ("Related Works"),
                p ("")
              ),
              
              tabPanel ("Methods"
                # Sample Demographics
                # Survey Development
                # Limitations
              ),
              
              tabPanel ("Experience Microaggressions and Microcompassions"
                # Kassy is doing this
              ),
              
              tabPanel ("First Response"
                # Hayden WordCloud
              ),

              tabPanel ("Perceived Effectiveness", 
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
                                        h3 ("Title"),
                                        p ("The bar graph above visualizes student's response to the question:"),
                                        tags$ul (tags$li ("How effective do you believe the signs are at introducing 
                                                 and promoting microcompassion on campus?")),
                                        p ("This question evaluates the students perception of the effectiveness to
                                           introduce or promote microcompassion on campus. Students answered on a 1 to 5
                                           scale with 1 being not very effective and 5 being very effective."), 
                                        plotlyOutput ("effective.plot")),
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
                              tabPanel ("Discussion", h3 ("Discussion about Signs"), p ("View by:"),
                                        actionButton ("view.all", "All"), actionButton ("view.all", "topic"),
                                        tableOutput ("explain.talk")),
                              tabPanel ("Specific Behavior Change", h3 ("Specific Behavior Change")),
                              tabPanel ("Analysis", h3 ("Analysis"))
                            )
                          )
                        )
              ),
            
              tabPanel ("Conclusions"
                # What we got from the data
                # What we recommend for the future of the Resilience Lab
                # (or other intervention entitities on campus)
              )
  )
)

# Word Cloud