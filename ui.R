library (shiny)

my.ui <- fluidPage (
  
  navbarPage ("UW Resilience Signs",
              
              tabPanel ("Home"
                # About the Signs
                # About
              ),
              
              tabPanel ("Methods"
                # Sample Demographics
                # Survey Development
                # Limitations
              ),
              
              tabPanel ("Experience Microaggressions and Microcompassions"
                # Kassy is doing this
              ),
              
              tabPanel ("Perception of Signs"
                # Hayden WordCloud
              ),

              tabPanel ("Effectiveness Evaluation"
                # Elisa and Jared will work on
                # two different visualizations
              ),
            
              tabPanel ("Conclusions"
                # What we got from the data
                # What we recommend for the future of the Resilience Lab
                # (or other intervention entitities on campus)
              )
  )
)

# Word Cloud