## This is the user-interface definition of a Shiny web application. 
## ui.R of years of schooling by continents

library(shiny)

## Defining UI 
shinyUI(fluidPage(
  
  ## Application title
  titlePanel(strong("Expected Years Of Schooling By Continents")),
  
  ## Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    ## Side Panel
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
    
    ## Main Panel
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Map", plotOutput("continent_map", width = 900, height = 600)),
                  tabPanel("Bar Chart", plotOutput("continent_bar", width = 900, height = 600))
    )
    )
  )
))
