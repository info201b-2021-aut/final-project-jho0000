library(dplyr)
library(shiny)
library(fmsb)
library(plotly)
library(leaflet)
library(devtools)
library(ggmap)
library(fontawesome)

#Change to load in Kaggle data csv file from directory if needed
KaggleData <- read.csv("../final-project-jho0000/data/KaggleData.csv")

#Devina's extra map
Kaggle <- filter(KaggleData, State == "Washington")
Kaggle <- filter(Kaggle, Year == 2014)
register_google(key = "AIzaSyCFvgKY8R37iTAFKAJlmk8S6OZITaD4BKg")
df <- select(Kaggle, City, State)
df <- cbind(Kaggle, geocode(paste(df$City, df$State)))
Kaggle <- merge(Kaggle, df)

#Kelly's line chart
incidents_per_year <- KaggleData %>%
  group_by(State, Year) %>%
  summarise(Incidents = sum(Incident))

intro_page <- tabPanel(icon = icon("comment"),
  titlePanel(h3("Examining Homicide")),
  h2(strong("A Reason to Kill For")),
  p("In 2010, the U.S. had the highest number of homicide cases recorded in its history. The relative volume of homicides now happening in the U.S. 
    has grown significantly from the amount of cases reported in the late 20th century, almost doubling. What can we conclude from the loss of lives
    all around the nation, what could be factors that lead to it?"),
  h2(strong("Curiosity Killed the Cat")),
  HTML("<p>When coming up with questions to answer, we had to ask ourselves <em>how big do we want our scope to be?</em> The dataset we used had 24 columns initially, 
    so we had to trim down the amount of information we wanted to work with. The main topics we wanted to analyze were:</p>"),
    tags$ul(
      tags$li("Number of U.S. homicide cases over the last few decades"), 
      tags$li("Age distribution of both homicide victims and perpetrators"), 
      tags$li("Type of weapons used in homicide cases"),
      tags$li("Locations where homicides occur the most and least"),
      tags$li("Number of homicide cases by state and year")
    ),
  p(strong("As Washingtonians, our group ultimately decided that we wanted to investigate the statistics here in Washington state, in addition to looking into the other states in the U.S.")),
  br(),
  p(strong("Links")),
    tags$ul(
      tags$li(tags$a(href = "https://www.kaggle.com/murderaccountability/homicide-reports?select=database.csv", "Kaggle Data Source")),
      tags$li(tags$a(href = "https://info201b-2021-aut.github.io/final-project-jho0000/", "Group R Markdown Site")),
    ),
  br(),
  HTML("<b>R Packages Used:</b><p> dplyr, shiny, fmsb, plotly, leaflet, devtools, ggmap, fontawesome</p>"),
  HTML("<b>Group Members:</b><p>John Ho, Lucy Lin, Brianna Pak, Devina Tavathia, Kelly Wang</p>"),
  img(src = "shiny.png")
)

victim_age_scatter <- tabPanel(icon = icon("user-slash"),
  titlePanel(h3("Victim Age Distribution in WA")),
  sidebarLayout(
    sidebarPanel(#style = "background: grey",
      wellPanel(style = "background: white",
        h2(strong("Plot Information")),
        p("A point of interest we wanted to visualize was the distribution of victim ages in Washington State. This plot shows the range and number of homicides
        for corresponding ages for a certain year. Each datapoint has a tooltip containing its respective victim age and the amount of occurences."),
        br(),
        p("The data spans from 1980 to 2014."),
      ),
      wellPanel(style = "background: white",
        selectInput(
          inputId = "selected_year",
          label = "Select a Year: ",
          choices = unique(KaggleData$Year)),
        ),
    ),
    mainPanel(
      plotlyOutput("Incident_Scatter")
    )
  ),
  tags$head(
    tags$style(HTML("@import url('https://fonts.googleapis.com/css?family=Rancho&effect=shadow-multiple');
      body {
        background-color: #ffffff;
        color: #444444;
      }
      h3 {
        font-size: 16px;
      }
      h2 {
        font-family: 'Arial', serif;
        font-size: 18px;
        color: #1f77b4;
      }
      .shiny-input-container {
        color: #1f77b4;
      }"))
  )
)

theMap <- tabPanel(icon = icon("map-pin"),
  titlePanel(h3("Homicide Locations in WA (2014)")),
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(#style = "background: grey",
      wellPanel(style = "background: white",
        h2(strong("Map Information")),
        p("Wondering where homicides happen across the state of Washington? This map shows the locations of cases recorded in 2014 along with the month and weapon used."),
        br(),
        p("Note that the data can be sorted by sex and race of the homicide victims or perpetrators.")
      ),
      wellPanel(style = "background: white",
        selectInput(
        inputId = "analysis_var",
        label = "Level of Analysis:",
        choices = c("Victim.Sex", "Perpetrator.Sex", "Victim.Race", "Perpetrator.Race")),
      ),
    ),
    # Display the map and table in the main panel
    mainPanel(
      leafletOutput("murder_map") # reactive output provided by leaflet
    )
  )
)

Linechart_kelly <- tabPanel(icon = icon("chart-line"),
  titlePanel(h3("Number of Homicide Incidents Per Year")),
  sidebarLayout(
    sidebarPanel(#style = "background: grey",
      wellPanel(style = "background: white",
        h2(strong("Graph Information")),
        p("The number of homicide cases are not evenly distributed across every state. This line graph shows the amount of homicide cases in a selected state according to the datasheet.")
      ),
      wellPanel(style = "background: white", 
        selectizeInput("selectStates", label = "Select a State:",
        choices = unique(incidents_per_year$State), multiple = FALSE),
      ),
    ),
    mainPanel(
      plotlyOutput("line")
    )
  )
)

conclusion_view <- tabPanel(icon = icon("book"),
  titlePanel(h3("Conclusion")),
  h2(strong("Summary")),
  p("Our goal for this project was to learn more about the motives and
    correlations from the data trends of homicide cases reported in the U.S. We used the Kaggle data set to 
    explore these points and learn more about the data set by creating graphs and visualizing the numbers. 
    Our specific takeaways focus on the details and characteristics of the people that make up a homicide: 
    the victim, perpetrator, and weapon used. These takeaways are important to focus on as we can figure out
    any patterns or highlight substantial numbers, which the government can use to find the next steps on how
    to lessen homicide case numbers in the U.S."),
  h2(strong("Takeaway 1")),
  p("Our first takeaway is that teenagers and young adults have the most victims (and perpetrators) out 
    of any age group. Both victims and perpetrators had the highest frequency at the age range of about 20 
    to 25 years old. The count of victims and perpetrators both go down after the age of 25, and this may be 
    because of the pressure of going into adulthood. However, some people try to survive and get by which 
    unfortunately ends up hurting others. Young adults are more than capable to be independent in carrying out
    actions even as extreme as causing a homicide. The count may also go down after the age of 25 due to most 
    perpetrators being put in jail and therefore lessening the number of perpetrators out in public, meaning 
    fewer chances of another victim. Based on this information, there should be more resources and help for 
    those who are in their young adult years, or even in their adolescence, to prevent these types of events 
    from keep occurring."),
  h2(strong("Takeaway 2")),
  p("A key takeaway is that handguns and firearms are the most frequently used weapons in homicides by a
    large margin than any other weapon in the dataset. This calls to the question as to why is it so widely 
    used for homicides. It may be because of the sheer effectiveness of using the gun, being relatively accessible
    and easy to use. If gun control is such a prevalent problem that makes up the majority of homicide cases, 
    then the government should look at how they can enforce gun control and prevent guns from falling into the 
    wrong hands. The use of handguns is not only seen in homicides, but also in gun culture in the U.S. and is 
    seen often through the media and news."),
  h2(strong("Takeaway 3")),
  p("One of the more intricate things to explore in the data set was the number of homicide cases across states
    given the window of time. We concluded from the line graph that the number of homicides has been at a stable 
    high compared to the amount in the late 1900s, with more states having a steep incline of homicide cases 
    compared to states gradually declining. This is concerning as we cannot know exactly why homicide has increased
    over the years, but we have some points for consideration. As mentioned before, weapons are accessible for the 
    amount of harm they can do, and gun culture is as predominant as ever within the nation's politics. The amount
    of guns and firearms is astoundingly high in general, being mass-produced and many people owning more than just
    one. Gang culture can be a topic to be explored, especially with young adults and adolescents being involved as 
    both victims and perpetrators in homicides. The government should look at how they are regulating gun control 
    and the main reasons that these homicides occur, educating people on what to watch out for and report if there 
    is any suspicious activity."),
  h2(strong("Notes and Flaws in Visualizations")),
  p("Some flaws in our visualizations include the states' line graphs not being rational with the numbers. For 
    example, Florida's graph from 2006 onwards reports around 656k to 512k homicide incidents per year...which sounds
    impossible. Working with messy world data that could be hard to organize, could lead to misinterpretations or 
    inaccurate numbers. We thought for that graph in particular that the data had accumulated the number of homicide
    incidents in that state, but saw that the numbers went up by 1 for every new row (which is odd). A few other 
    states had unrealistic numbers in their graphs as well, having a much larger range from the typical triple-digit
    number of homicide cases per year."),
  p("Additionally, some of the scatter plots have a number of victims being 998 years old. Yeah, we are scratching our heads
    too on how these outliers appeared on the data set."),
  h2(strong("Final Thoughts")),
  p("Exploring this dataset was interesting but it does call for concern about the way our government is promoting
    safety for citizens and how they are controlling the use and accessibility of weapons. As data is collected and evaluated,
    we hope to see laws being changed in in order to see a decline in homicide cases compared to this Kaggle data set that we explored."),
  br()
) 

ui <- navbarPage(inverse = TRUE,
  titlePanel("Final Deliverable"),
  intro_page,
  victim_age_scatter,
  theMap,
  Linechart_kelly,
  conclusion_view
  
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
    plot_ly(Scatter_byState(input$selected_year), x = ~Victim.Age, y = ~Incidents_in_year,  type = "scatter", mode = "markers", text = ~paste("Victim Age: ", Victim.Age, "Number of Homicides: ", Incidents_in_year))%>%
      layout(title = 'Number of Homicides By Victim Age and Selected Year in WA ', xaxis = list(title = 'Victim Age'), 
             yaxis = list(title = 'Number of Homicide Incidents'), width = 1100, height = 750)

  })
  
  #t===his is Devina's sexy code -------------------------------------------------------------
  # Define a map to render in the UI
  output$murder_map <- renderLeaflet({
    
    # Construct a color palette (scale) based on chosen analysis variable
    palette_fn <- colorFactor(palette = "Dark2", domain = Kaggle[[input$analysis_var]])
    leaflet(data = Kaggle) %>%
      addProviderTiles("Stamen.TonerLite") %>% # add Stamen Map Tiles
      addCircleMarkers( # add markers for each murder
        lng = ~ lon,
        lat = ~ lat,
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
  
  #this is Kelly's sexy code ----------------------------------------------------------------
  output$line <- renderPlotly({
    plot_ly(incidents_per_year, x = ~Year, y = ~Incidents) %>%
      filter(State %in% input$selectStates) %>%
      add_lines()
  })
  
}

shinyApp(ui, server)
