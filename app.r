library("dplyr")
library(shiny)
library(fmsb)
library(plotly)

KaggleData <- read.csv("C:/Users/devin/Documents/201Projects/final-project-jho0000/data/KaggleData.csv")

#This is for Devina's extra map
Kaggle <- filter(KaggleData, State == "Washington")
Kaggle <- filter(Kaggle, Year == 2014)
register_google(key = "AIzaSyCFvgKY8R37iTAFKAJlmk8S6OZITaD4BKg")
df <- select(Kaggle, City, State)
df <- cbind(Kaggle, geocode(paste(df$City, df$State)))
Kaggle <- merge(Kaggle, df)



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

theMap <- tabPanel(
  titlePanel("Murder Locations in Washington (2014)"),
  
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "analysis_var",
        label = "Level of Analysis",
        choices = c("Victim.Sex", "Perpetrator.Sex", "Victim.Race", "Perpetrator.Race")
      )
    ),
    
    # Display the map and table in the main panel
    mainPanel(
      leafletOutput("murder_map") # reactive output provided by leaflet
    )
  )
)

ui <- navbarPage(
  titlePanel("The Project"),
  intro_page,
  victim_age_scatter,
  theMap
  
)

server <- function(input, output, session) {
  
  #This is Lucy's code------------------------------------------------------------------------

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
  
  #this is Devina's sexy code -------------------------------------------------------------
  # Define a map to render in the UI
  output$murder_map <- renderLeaflet({
    
    # Construct a color palette (scale) based on chosen analysis variable
    palette_fn <- colorFactor(palette = "Dark2", domain = Kaggle[[input$analysis_var]])
    leaflet(data = Kaggle) %>%
      addProviderTiles("Stamen.TonerLite") %>% # add Stamen Map Tiles
      addCircleMarkers( # add markers for each murder
        lng = ~ lon,
        lat= ~ lat,
        label = ~paste0(Month, ", ", Weapon), # add a hover label: victim's name and age
        color = ~palette_fn(Kaggle[[input$analysis_var]]), # color points by race
        fillOpacity = .7,
        radius = 4,
        stroke = FALSE
      ) %>%
      addLegend( # include a legend on the plot
        position = "bottomright",
        title = "Race",
        pal = palette_fn, # the palette to label
        values = Kaggle[[input$analysis_var]], # again, using double-bracket notation
        opacity = 1 # legend is opaque
      )
    
  })
  
}

shinyApp(ui, server)
