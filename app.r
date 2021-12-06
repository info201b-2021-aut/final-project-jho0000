library("dplyr")
library(shiny)
library(fmsb)
library(plotly)

KaggleData <- read.csv("C:/Users/lucyl/OneDrive/Desktop/final-project-jho0000/data/KaggleData.csv")

intro_page <- tabPanel(
  titlePanel("examining homocide"),
  p("this does blah blah blah")
)

victim_age_scatter <- tabPanel(
  titlePanel("Scatterplot of Victim Age Distribution in Washington"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "selected_year",
        label = "Select a Year: ",
        choices = unique(KaggleData$Year)
      ),
    ),
    mainPanel(
      plotlyOutput("Incident_Scatter")
    )
  ),
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css?family=Rancho&effect=shadow-multiple');
      body {
        background-color: #ADD8E6;
        color: #444444;
      }
      h2 {
        font-family: 'Rancho', serif;
        text-shadow: 4px 4px 4px #aaa;
      }
      .shiny-input-container {
        color: #FFA500;
      }"))
  )
)

thefuckingMap <- 

ui <- navbarPage(
  titlePanel("The Project"),
  intro_page,
  victim_age_scatter
  
)

server <- function(input, output, session) {

  Scatter_byState <- function(input_Year){
     Incidents_df <- select(KaggleData, Year, State, Incident, Victim.Age) %>% 
       filter(State=="Washington") %>% 
       filter(Year==input_Year) %>% 
       group_by(Victim.Age) %>% 
       summarise(Incidents_in_year = sum(Incident))
     
     return(Incidents_df)
  }
  
  output$Incident_Scatter <- renderPlotly({
    plot_ly(Scatter_byState(input$selected_year), x = ~Victim.Age, y = ~Incidents_in_year,  type = "scatter", mode = "markers", text = ~paste("Victim Age: ", Victim.Age, "Number of Homocide: ", Incidents_in_year))%>%
      layout(title = 'Number of Homocides based on Victim Age in selected year in Washignton State', xaxis = list(title = 'Victim Age'), 
             yaxis = list(title = 'Number of Homocide Incidents'), width = 1100, height = 750)

  })  
}

shinyApp(ui, server)
