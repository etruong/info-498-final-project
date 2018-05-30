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
                                          includeHTML("scripts/methods-tab/methods_tab.html")

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
                                                tabPanel ("Analysis", h3 ("Analysis"), 
                                                          p("For the most part, individuals, regardless of race or grade level, are reporting that the effectiveness of the signs are either ineffective or neither ineffective/effective. Although when analyzing the data based on the major students pursued, there are interesting results. STEM majors are reporting more that the signs are ineffective than those who are not STEM majors who are mainly reporting that the sign intervention were neither ineffective/effective. We wanted to analyze the two different major categories (STEM vs Non-STEM) because each major category covers different topics and have differing demands of their students. Though these results are likely skewed by our sample size. There are less Non-STEM major individuals taking our survey than STEM majors taking our survey. Due to this, we cannot have conclusive results."),
                                                          p("When analyzing the variables correlated with the percieved effectiveness of the signs, there was not a correlation between the microcompassion, microaggression, and mental health variables with percieved effectiveness. This means that how much microcompassion or microaggression students experienced (in relation to their peers) is not related with how effective they percieved the signs as well as how they rated their mental health. This was not what we expected. We predicted a plausible outcome would be that the higher an individual rated their experience with microaggression the higher they rated for percieved effectiveness of the signs. We also predicted that the lower a person rated their mental health, they would percieve the signs as effective. We predicted this because in both cases, each individual are in vulnerable states, thus they would possibly be impacted by the signs more. This was not that case."),
                                                          p("A plausible reasoning for this outcome is likely due to the fact that the data is mainly self-reported. Students may be basing their mental health on the current state that they were in while taking the survey. The question about mental health aimed to attain data on surveyor's general mental health state. This may explain the lack of correlation between the percieved effectiveness of signs and mental health. Also, individuals were taking this survey a month or a few weeks after the sign intervention was taken down. Therefore, students had to reflect back on their experiences. The data that was reported may be data pertaining to how the students felt at the moment they took the survey, instead of how they reacted to the signs.")
                                                          )
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
                                          h3("Results"),
                                          p("In the first question of our survey, we asked students to name one word that came to mind for one of the sign’s message: “Your busy-ness is not a measure of your worthiness.” For each word, we used Google’s Sentiment Analysis tool to determine whether students had a negative or positive response to the sign on average, yet the results reveal that students had a neutral response to the sign’s message."),
                                          tags$br(),
                                          p("When analyzing the student’s perceived effectiveness of the signs, a majority of the students regardless of the year in school or ethnicity reported that the signs were ineffective or neither ineffective/effective. Although interestingly, we noticed that a majority of students pursuing STEM majors reported that the signs were ineffective while a majority students pursuing non-STEM majors reported that the intervention was neither ineffective/effective. However, a likely reason for these results was that our sample consisted of more students pursuing STEM majors than not."),
                                          tags$br(),
                                          p("When evaluating the changes in behavior of students after being exposed to the signs, a majority of students reported not having a behavior change at all due to the signs. For the small few who did respond that their behavior did change, they essentially reported that the signs altered their mood from positive to negative, and the signs served as a reminder to them to place their life in perspective or to remind them to be positive. This is significant because while a majority responded that the signs were ineffective or did not change their behavior, some students were impacted by the signs messages in a positive manner."),
                                          tags$br(),
                                          p("The qualitative data obtained to specifically obtain what individuals discussed about the signs was interesting because students mainly talked about the sign memes or the hilarity of the signs. 14 out of the 33 responses pertained to the students discussing about the sign memes and about how funny the signs were.  Some students (6 out of the 33 responses) mentioned how they talked about the signs being unhelpful. Though interestingly, it was also negative because for one student it did trigger negative experiences for them. In general, students discussed about the negative effect the signs had, but it was also a shared topic the students could share and laugh about. We argue that while it was a trigger for students and impacted students in a negative way, it did, momentarily, connect individuals together and relieve stress. On the other hand, positive remarks (3 out of 33 response were positive) about the signs were minimal and insignificant."),
                                          tags$br(),
                                          p("To determine the effectiveness of the signs in spreading compassion, we asked about how uplifted students felt after being exposed to the signs which 54 of the respondents out of 124 answered “not uplifted at all” or “feeling a bit uplifting,” 38 answered “somewhat uplifted,” and 32 answered “uplifted” or “very uplifted.” We additionally asked whether or not students felt discouraged because of the signs. If a majority of students answered “yes” to this question, the signs would be deemed as having the opposite effect than intended. Although for the discouraged question, 81 individuals reported the signs being “not discouraging at all” or “a bit discouraging.”"),
                                          tags$br(),
                                          p("To delve deeper into the results of our data, we analyzed the correlations between specific responses. Interestingly, people who experienced more microaggressions  perceived the signs as uplifting. Another correlational finding was that individuals who experienced more micro compassion tended to perceive the sign intervention as effective."),
                                          tags$br(),
                                      
                                          h3("Conclusion"),
                                          
                                          p("Collectively, our results suggest that students had a neutral or negative response to the signs. Students did not feel discouraged by the signs, and they were slightly uplifted by the signs. It did not impact them to change their behavior toward others or their attitude. The sentimental analysis we performed is evidence that the students had a neutral response to the signs. Although the results for the sentimental analysis are likely due to the methods we used to attain the data. More specifically, it is possible that the students did not have enough time to think about the word or that using a one word answer was not the best method to determine their response."),
                                          tags$br(),
                                          p("When asking students directly how effective they felt that the sign intervention was at promoting compassion on campus, a majority students responded that the signs were not effective and neither effective/not effective. Though that the results reveal that the signs are leaning towards ineffective, we recognize the signs acted and became a topical platform through which individuals discussed to relieve stress, satirically joke about, and identify with each other through. The results also reveal that while there was not a holistic positive impact on every student exposed to the signs on campus, for some it did uplift their day. The survey results suggest that the the UW Resilience lab signs were ineffective in achieving its goals to promote compassion on campus, yet when analyzing correlational relationships between responses, individuals who rated experiencing more microaggressions on campus perceived the signs as uplifting. This is significant because it supports the main purpose of the signs as a way to combat microaggressions with micro compassion. One reason for this result is individual’s who experience more microaggressions in relation to their peers are more vulnerable emotionally and are thus affect more by small acts of kindness. 
                                            Due to this correlational, it supports the fact that the UW Resilience signs were effective for its intended purpose."),
                                          tags$br(),
                                          p("Regardless, if the Resilience Lab’s is keen on still employing their Signs Intervention to promote compassion amongst the student body, we suggest performing a cost-benefit analysis. One of our concerns is that the intervention cost roughly $600.00 (20 signs at $30 each), and it may be beneficial to quantify how much these signs are adding positive value to student’s lives. $600, while minute to the university’s overall budget, is still able to be leveraged in many different ways.")
                                          
                                )
                    )
)

# Word Cloud