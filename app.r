library("dplyr")
library(shiny)
library(fmsb)
library(plotly)
library("shinyURL")

KaggleData <- read.csv("C:/Users/devin/Documents/201Projects/final-project-jho0000/data/KaggleData.csv")

#This is for Devina's extra map
Kaggle <- filter(KaggleData, State == "Washington")
Kaggle <- filter(Kaggle, Year == 2014)
register_google(key = "AIzaSyCFvgKY8R37iTAFKAJlmk8S6OZITaD4BKg")
df <- select(Kaggle, City, State)
df <- cbind(Kaggle, geocode(paste(df$City, df$State)))
Kaggle <- merge(Kaggle, df)

#this is  Kelly's line chart
incidents_per_year <- KaggleData %>%
  group_by(State, Year) %>%
  summarise(Incidents = sum(Incident))


intro_page <- tabPanel(
  titlePanel("Examining Homocide"),
  p("this does blah blah blah"),
  shinyURL.ui()
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
        background-color:#b19cd9;
        color: #444444;
      }
      h2 {
        font-family: 'Trebuchet MS', sans-serif;
        font-size: 16px;
      }
      .shiny-input-container {
        color: #FFD700;
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

Linechart_kelly <-  tabPanel(
  titlePanel("Number of Homicide Incidents Per Year"),
  sidebarPanel(
    selectizeInput("selectStates", label = h3("Select state"),
    choices = unique(incidents_per_year$State), multiple = FALSE)),
      mainPanel(
      plotlyOutput("line"))
)

conclusion_view<- tabPanel(
  titlePanel("Conclusion"),
  h1("Summary"),
  p("Our goal for this project was to learn more about the motives,
correlations, and data trends of homicide cases in the US. We used the Kaggle
data set to explore these points and learn more about the data set by creating
graphs and interpreting it. Our specific takeaways focus on the three
things that make up a homicide which is the victim, perpetrator, and weapon used. 
These takeaways are important to focus on as we can figure out the next steps that can be made by the government
on how to lessen the number of homicide cases that occur in the US
."),
  strong("Specific Takeaway 1"),
  p("One of the most important things to explore in the data set was the number of
homicide cases in the US from 1980-2014. We concluded from the line graph 
that the number of homicides has been at a stable high compared to the amount in the 
late 1900s. This is concerning as we don't know why homicide has increased over the years
it may be because of the increase of violent video games, easier accessibility to weapons, or
economic and societal changes occurring. The government should look at how they are regarding
weapon control and the main reasons that these homicides occur that way
people know what to watch out for and report if there are any suspicions.
"),
  strong("Specific Takeaway 2"),
  p("Our second takeaway is that teenagers and young adults have the most victims and perpetrators
out of any age group. Both victims and perpetrators had the highest frequency at the age
of 20 years old. These two may correlate with each other as they both are the highest at the same
age. The count of victims and perpetrators both go down after the age of 20, this may be because
of the pressure of going into adulthood and some people trying to survive and get by which
unfortunately ends up in hurting others. The count may also go down after the age of 25
because most people are put in jail and therefore there are not as many perpetrators
which mean less victims. Based on this information, there should be more resources
and help for those who are in their young adult years that way these types of events
don't keep occurring. 
"),
  strong("Specific Takeaway 3"),
  p("our last takeaway is that handguns are the most frequently used weapons in homicides by a far amount
    than the other weapons in the dataset. This calls to the question as to why is it the most used weapon for homicides.
    It may be because of the easiness of using the weapon or is it the most accessible for most people. If a handgun is 
    easy to get then the government should look at how they can enforce gun control and prevent the gun from getting into the
    wrong hands. The use of handguns aren't only seen in homicides but also seen in other events that can be heard on the news.
"),
  strong("Final Thoughts"),
  p("Exploring this dataset was interesting but it does call for concern about the way our government is promoting
    safety for citizens and how they are controlling the use and acessibility of weapons. As data is collected and evaluated,
    we hope to see laws being changed in in order to see a decline in homicide cases compared to this Kaggle data set that we explored. ")
) 

ui <- navbarPage(
  inverse = TRUE,
  titlePanel("The Project"),
  intro_page,
  victim_age_scatter,
  theMap,
  Linechart_kelly,
  conclusion_view
)

server <- function(input, output, session) {
  
  shinyURL.server(session)
  
  #This is Lucy's code------------------------------------------------------------------------

  Scatter_byState <- function(input_Year){
     Incidents_df <- select(KaggleData, Year, State, Incident, Victim.Age) %>% 
       filter(State=="Washington") %>% 
       filter(Year==input_Year) %>% 
       filter(Victim.Age <= 150) %>% 
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
  
  #this is kellys sexy code
  output$line <- renderPlotly({
    plot_ly(incidents_per_year, x = ~Year, y = ~Incidents) %>%
      filter(State %in% input$selectStates) %>%
      add_lines()
  })
  
}

shinyApp(ui, server)
