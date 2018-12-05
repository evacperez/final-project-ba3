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
    tabPanel(title = "Introduction", value = "intro", 
             titlePanel("About Our Project")),
    
    ## YEARS OF SCHOOLING BY CONTINENTS (QUESTION 1)
    tabPanel(title = "Continent", value = "q1",  
             titlePanel(strong("Expected Years Of Schooling By Continents")),
             # A summary about these charts related to continent
             p("The following map and bar chart give the descriptive information
                and comparison about the number of schooling years between different continents. 
                The map and chart can be filtered by a specific continent button or 
                all continents button as well as a specific year in the drop down menu."),
             # A conclusion for the question about continent
             p("Throughout the charts, we totally conclude that Europe continent has the smallest
               difference between countries in the number of schooling years, whereas Africa witnesses
               the most significant difference. Furthermore, filtering the years helps us figure out
               the slight growth trendency in the number of schooling years in all continents."),
             sidebarLayout(
               # Side Panel 
               sidebarPanel(
                 # Continent Filter (Using radio buttons type of widget)
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
                 ## Year Filter (Using drop down menu type of widget)
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
               # Main Panel
               mainPanel(
                 # Creating the tab set for 2 different types of plots
                 tabsetPanel(type = "tabs",
                             tabPanel("Map", plotOutput("continent_map", width = 900, height = 600)),
                             tabPanel("Bar Chart", plotOutput("continent_bar", width = 900, height = 600))
                 )
               )
      )),
    tabPanel(title = "Female and Male", value = "q2",
             titlePanel("Female and Male Comparisons for Expected Years of Schooling Per Country"),
             sidebarLayout(
               sidebarPanel(
                 
                 # Select button dataset of both female and male, female, or male
                 radioButtons(inputId = "femaleMaleSelect",
                              label = "Select Data of:",
                              choices = list("Both Female and Male", "Female", "Male"),
                              selected = "Both Female and Male"),
                 # Select an input range of years
                 sliderInput(inputId = "femaleMaleYear", 
                             label = ("Year Range:"),
                             sep = "", 
                             min = 1990, 
                             max = 2017, 
                             value = c(1990, 2017), 
                             ticks = FALSE),
                 # Select input of country choice
                 selectInput(inputId = "femaleMaleCountry",
                             label = "Select Country:",
                             choices = c("Afghanistan","Albania","Algeria","Andorra","Angola","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia (Plurinational State of)","Botswana","Brazil","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo","Congo (Democratic Republic of the)","Costa Rica","Croatia","Cuba","Cyprus","Czechia","Côte d'Ivoire","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Estonia","Swaziland","Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hong Kong, China (SAR)","Hungary","Iceland","India","Indonesia","Iran (Islamic Republic of)","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Korea (Republic of)","Kuwait","Kyrgyzstan","Lao People's Democratic Republic","Latvia","Lebanon","Lesotho","Libya","Lithuania","Luxembourg","Madagascar","Malawi","Malaysia","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova (Republic of)","Mongolia","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russian Federation","Rwanda","Saint Kitts and Nevis","Saint Lucia","Saint Vincent and the Grenadines","Samoa","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","South Africa","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland","Syrian Arab Republic","Tajikistan","Tanzania (United Republic of)","Thailand","The former Yugoslav Republic of Macedonia","Togo","Tonga","Trinidad and Tobago","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Venezuela (Bolivarian Republic of)","Viet Nam","Yemen","Zambia","Zimbabwe"),
                             selected = "United States")
               ),
               mainPanel(plotOutput("q2"))
             ),
  tags$br()
  )
))