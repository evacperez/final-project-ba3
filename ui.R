library(shiny)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://use.fontawesome.com/releases/v5.5.0/css/all.css"),
    tags$script(src = "index.js", type = "text/javascript")
  ),
  
  titlePanel("Expected Years of Schooling"),
  tabsetPanel(id = "main",
    tabPanel(title = "Welcome!", value = "home", htmlOutput("home")),
    tabPanel(title = "Creators", value = "create", textOutput("create")),
    tabPanel(title = "About", value = "intro", textOutput("intro")),
    tabPanel(title = "Continents", value = "q1"),
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