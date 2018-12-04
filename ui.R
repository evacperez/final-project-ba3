library(shiny)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://use.fontawesome.com/releases/v5.5.0/css/all.css"),
    tags$script(src = "index.js", type = "text/javascript")
  ),
  
  titlePanel("Expected Years Of Schooling"),
  tabsetPanel(id = "main",
    tabPanel(title = "Welcome!", value = "home", htmlOutput("home")),
    tabPanel(title = "Introduction", value = "intro", textOutput("intro")),
    
    ## YEARS OF SCHOOLING BY CONTINENTS (QUESTION 1)
    tabPanel(title = "Key Question #1", value = "q1",  
             titlePanel(strong("Expected Years Of Schooling By Continents")),
             p("The following map and bar chart give the descriptive information
                and comparison about the number of schooling years between different continents. 
                The map and chart can be filtered by a specific continent button or 
                all continents button as well as a specific year in the drop down menu."),
             p("Throughout the charts, we totally conclude that Europe continent has the smallest
               difference between countries in the number of schooling years, whereas Africa witnesses
               the most significant difference. Furthermore, filtering the years helps us figure out
               the slight growth trendency in the number of schooling years in all continents."),
             sidebarLayout(
               sidebarPanel(
                 ## Continent Filter
                 helpText(h6("Choose a continent or all continents. 
                             The map and the bar chart will show the number of 
                             schooling years in the selected continent or all continents")),
                 radioButtons(
                   "continent",
                   "Continent",
                   c("All continents", "Asia", "Africa", "Americas",
                     "Europe", "Oceania"),
                   selected = "All continents"
                 ),
                 ## Year Filter
                 helpText(h6("Choose a specific year. The map will show the number of 
                             schooling years in this year")),
                 selectInput(
                   "year",
                   "Year",
                   c("1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997",
                     "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                     "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013",
                     "2014", "2015", "2016", "2017"),
                   selected = "1990"
                 )
                 ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Map", plotOutput("continent_map", width = 900, height = 600)),
                             tabPanel("Bar Chart", plotOutput("continent_bar", width = 900, height = 600))
                 )
               )
               ))
    
  ),
  
  tags$br()
  
)