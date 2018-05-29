library (shiny)
library (plotly)
library (shinythemes)

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
                h1("Survey Development and Design"),
                tags$img (class = "sign", src = "survey-sign-1.jpg", width = 300),
                p("Our survey starts out with the picture above, and asks survey takers what the first word that
                  comes to mind is upon seeing it. This is meant to gauge people's first reactions to the signs,
                  and to show this we created a word cloud. Two sections follow: Demographics and Resilience Lab Signs."),
                p("The demographics section is meant to gauge the demographics of our sample, and to determine the
                  possible need for weights. We ask about gender, ethnicy, age, year in school, major/intended major,
                  minor, own rating of mental health, experience regarding microaggressions and microcompassions
                  relative to peers, and whether or not they browse UW's main Facebook meme page: UW Teens for Boundless
                  Memes. This section ends by asking if the survey taker has seen the Resilience Lab signs, and
                  if they answer no, the survey closes as the rest of the questions are not applicable to these people."),
                p("The Resilience Lab Signs section is meant to further understand the survey taker's perceptions of, 
                  reactions to, and behavioral change from the signs. Here, we ask about where the people first saw 
                  the signs, whether or not they followed the website provided (resilience.uw.edu) on the signs, 
                  whether or not their feelings changed and how, how uplifted or discouraged they felt, if their 
                  behavior changed and how, if they've talked to others about the signs and what they talked about, and
                  finally, how they rate the effectiveness of the signs in terms of promoting microcompassions on campus."),
                p("Both sections are important as we used them to draw relationships among different factors within 
                  each of the sections (ethnicity versus mental health, rating of mental health versus exerpience with 
                  microaggressions, feelings of being uplifted versus rating of signs' effectiveness at promoting
                  microcompassions) but also among different factors between the two (major versus rating of signs' 
                  effectiveness at promoting microcompassions, rating of mental health versus feelings of being
                  uplifted)."),
                h1("Population and Sample Demographics"),
                p("The population of interest is the UW student community, as they are the main target of the 
                  Resilience Lab signs. In terms of keeping our sample representative of the UW student population,
                  we care most about two main demographical dimensions: ethnicity and major. The following tables show 
                  UW's makeup and theblah "), #add
                h1("Limitations"),
                p("The somethign something blah"), #add 
                p ("")
              ),
              
              tabPanel ("Experience Microaggressions and Microcompassions",
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
                            plotOutput("plotly")
                          )
                        )              ),
              
              tabPanel ("First Response",
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
                            wordcloud2Output("wordCloud")
                          )
                        )
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
            
              tabPanel ("Conclusions"
                # What we got from the data
                # What we recommend for the future of the Resilience Lab
                # (or other intervention entitities on campus)
              )
  )
)

# Word Cloud