library(shiny)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://use.fontawesome.com/releases/v5.5.0/css/all.css"),
    tags$script(src = "index.js", type = "text/javascript")
  ),
  titlePanel("How education availability has changed between 1990 and 2017"),
  
  tabsetPanel(id = "main",
    tabPanel(title = "Home", value = "home", htmlOutput("home")),
    tabPanel(title = "Creators", value = "creators", htmlOutput("creators")),
    tabPanel(title = "About", value = "intro",
             titlePanel("About Our Project"),
             p("Our project analyzes the trends of the UN’s database on expected years of schooling
               around the world. We divide up the information so our user can interact with the data to
               see how certain demographics have different levels of development."),
             h3("Data"),
             p("Our team worked on with “Human Development Data (1990-2017)”) from
               the United Nations Development Programme linked to the World Bank Dataset.
               Our project will be based on CSV files generated from there.
               We have chosen to study Education and analyze the three subcategories:
               Expected years of schooling (years), Expected years of schooling, female (years),
               Expected years of schooling, male (years)."),
             a("The data can be found here", href = "http://hdr.undp.org/en/data"),
             h3("Audience"),
             p("The target audience would be economists devoted to education:
               people interested in demographics within the educational system throughout the nation.
               More often, these are individuals who are social scientists studying the relationship
               between human behavior and the levels of development in various countries across the world"),
             h3("Big Questions"),
             p("Our team project will answer the following questions for our honed audience:"),
             p("1. Do Western nations have a higher or lower expected years of schooling rate compared to Eastern nations?"),
             p("2. How do male and female expected years of schooling rates compare over the years for all the countries with data available?"),
             p("3. When using the UN’s categorization of developed and developing nations, do developing nations have a lower expected years of
                     schooling rate compared to developed nations, and if so, by how much of a gap?"),
             h3("Analysis"),
             p("We constructed totally three major tab to answer our three big question:"),
             p("1. First tab goes deep into exploring the information and comparison in the schooling years
                between different countries grouped by their continents as well as filtered in a specific year throughut maps and bar charts visualization."),
             p("2. Second tab builds the line graphs to answer questions: How has the expected years of schooling changes per country between 1990 and 2017? 
                How do these rates change when comparing between females and males?"),
             p("3. Third tab intakes the data on expected years of schooling for both males and females combined and outputs 
              an interactive bar plot that shows the expected years of schooling for the countries categorized by developed nations and developing nations. ")),

    ## YEARS OF SCHOOLING BY CONTINENTS (QUESTION 1)
    tabPanel(title = "Continents", value = "q1",
             titlePanel(strong("Expected Years Of Schooling By Continents")),
             # A summary about these charts related to continent
             p("Are there any difference in expected years of schooling for both male and female between different 
               continents and different years in the world?"),
             p(" The following map and bar chart give the descriptive information
                and comparison about the number of schooling years between different continents in different years. 
                To explore the data visualization, the map and chart can be filtered by a specific continent button or 
                all continents button as well as a specific year in the drop down menu."),
             # A conclusion for the question about continent
             p("Throughout the charts, we totally conclude that Europe continent has the smallest
               difference between countries in the number of schooling years, whereas Africa witnesses
               the most significant difference. Furthermore, filtering the years helps us figure out
               the slight growth trendency in the number of schooling years in all continents of the world."),
             sidebarLayout(
               # Side Panel
               sidebarPanel(
                 # Continent Filter (Using radio buttons type of widget)
                 helpText(h6("Choose a continent or all continents.
                             The map and the bar chart will show the number of
                             schooling years in the selected continent or all continents")),
                 radioButtons(
                   "continent",
                   "Continent:",
                   c("All continents", "Asia", "Africa", "Americas",
                     "Europe", "Oceania"),
                   selected = "All continents"
                 ),
                 ## Year Filter (Using drop down menu type of widget)
                 helpText(h6("Choose a specific year. The map will show the number of
                             schooling years in this year")),
                 selectInput(
                   "year",
                   "Year:",
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
                             tabPanel("Map", plotOutput("continent_map", height = 600)),
                             tabPanel("Bar Chart", plotOutput("continent_bar"))
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
  ),
  tabPanel(title = "Developing and Developed Nations", value = "q3",
           # Title of shiny app page
           titlePanel("UN Developed Nations vs. Developing Nations"),
           
           # Creates sidebar layout 
           sidebarLayout(
             sidebarPanel(
               
               # Created radio buttons to choose Developed or Developing
               radioButtons(inputId = "nations",
                            "Data On:",
                            choices = list("Developed", "Developing"),
                            selected = "Developed"),
               
               # Creates select box widget for the given years in the data set of 
               # UN nations from server.R data.
               selectInput(inputId = "years",
                           label = "Years:",
                           choices = 1990:2017)
             ),
             
             # Creates area where bar plot will be displayed
             mainPanel(
               plotOutput("barPlot")
             )
           )
           ),
  tabPanel(title = "Donations", value = "donate", 
           titlePanel("Please donate $1 to help children in developing countries receive a fair education."),
           # A summary about how donating will help
           p("Children in third world countries need your help to have a chance at receiving a fair education.
             All donations will go towards building and supplying public schooling systems that are close to home.
             By helping third world countries raise up their expected years of schooling, countries will gain long term value that improves domestic standards of living, and in turn world-wide productivity."),
           p("A small donation today can make a world of difference tomorrow!"))
)
)
