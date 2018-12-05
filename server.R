## This is the server logic of a Shiny web application. 
source("q2.R")

## Loading packages
library("shiny")
library("ggplot2")
library("maps")
library("dplyr")
library("countrycode")
library("mapproj")

## Setting current directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

## Setting html homepage
file_name <- "www/carousel.html"
homepage_html <- readChar(file_name, file.info(file_name)$size)

## Reading the data 
## Phuongle's data
data <- read.csv("Data/data.csv", stringsAsFactors = FALSE)
updated_data <- data %>% 
  mutate(Continent = countrycode(data$Country, 'country.name', 'continent')) 
colnames(updated_data)[2] <- "region"
updated_data$region <- substring(paste0(updated_data$region), 2)
world_area <- map_data("world")
world_area$region[world_area$region == "UK"] <- "United Kingdom"
data$Country <- substring(data$Country, 2)

## Defining server 
server <- function(input, output, session) {
  observeEvent(input$controller, {
    updateTabsetPanel(session, "main",
                      selected = input$controller
    )
  })
  
  observeEvent(input$main, {
    session$sendCustomMessage('page', input$main)
  })
  
  ## Home tabPanel Output
  output$home <- renderUI({
    tags$div(
      HTML(homepage_html)
    )
  })
  
  output$creators <- renderUI({
    "Project Creators: Eva Perez, Jeff Zhang, Joselly Anne Ongoco, Phuong Le"
    about_file <- "www/about.html"
    about_html <- readChar(about_file, file.info(file_name)$size)
    HTML(about_html)
  })

  # output$intro <- renderText({
  #   "An Introduction to our Project..."
  # })
  
  ## YEARS OF SCHOOLING BY CONTINENTS (QUESTION 1)
  # Creating continent map output
  output$continent_map <- renderPlot({
    map_data <- select(updated_data, region, Continent, paste0("X", input$year))
    world_data <- world_area %>% 
      full_join(map_data, by = "region") 
    
    # If-else statement to filter All continents or a continent
    if (input$continent == "All continents"){
      # Filtering data for the world map
      world_data <- select(world_data, long, lat, group, order, region, 
                           subregion, Continent, paste0("X", input$year))
      colnames(world_data)[8] <- "year"
      # Creating the world map 
      ggplot(world_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = world_data$year)) +
        scale_fill_gradient(low = "#7CA7BE", high = "#36596C") +
        theme(plot.title = element_text(color = "black", face = "bold")) +
        theme(axis.title = element_text(color = "black", face = "bold")) +
        labs(title = paste("The number of schooling years in countries of", input$continent),
             fill = "Schooling Years (years)") 
    }
    else {
      # Filtering data for the continent map
      continent_map_data <- world_data %>%
        filter(Continent == input$continent) 
      colnames(continent_map_data)[8] <- "year"
      # Creating the specific continent map
      ggplot(continent_map_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = continent_map_data$year)) +
        scale_fill_gradient(low = "#7CA7BE", high = "#36596C") +
        theme(plot.title = element_text(color = "black", face = "bold")) +
        theme(axis.title = element_text(color = "black", face = "bold")) +
        labs(title = paste("The number of schooling years in countries of", input$continent),
             fill = "Schooling Years (years)")  
    }
  })
  
  ## Creating continent bar chart output
  output$continent_bar <- renderPlot({
    if (input$continent == "All continents"){
      # Filtering data for world bar chart
      world_bar_data <- updated_data %>% 
        select(region, Continent, paste0("X", input$year))
      colnames(world_bar_data)[3] <- "years"
      # Creating the world bar chart 
      plot <- ggplot(world_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "#7CA7BE") +
        geom_text(
          aes(label = years, y = years + 0.05),
          position = position_dodge(0.9),
          vjust = 0,
          color = "grey34",
          size = 2) +  
        scale_y_continuous(breaks=c(seq(0, 25, 3)), limits = c(0, 25)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 6)) +
        theme(plot.title = element_text(color = "black", face = "bold")) +
        theme(axis.title = element_text(color = "black", face = "bold")) +
        ylab("The number of schooling years") +
        xlab("All countries in the world") +
        labs(title = "The number of schooling years in all countries 
                            around the world")
    }
    else {
      # Filtering data for a continent bar chart
      continent_bar_data <- updated_data %>% 
        filter(Continent == input$continent) %>%
        select(region, Continent, paste0("X", input$year))
      colnames(continent_bar_data)[3] <- "years"
      # Creating the continent bar chart
      plot <- ggplot(continent_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "#7CA7BE") +
        geom_text(
          aes(label = years, y = years + 0.05),
          position = position_dodge(0.9),
          vjust = 0,
          color = "grey34",
          size = 3) +  
        scale_y_continuous(breaks=c(seq(0, 25, 3)), limits = c(0, 25)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        theme(plot.title = element_text(color = "black", face = "bold")) +
        theme(axis.title = element_text(color = "black", face = "bold")) +
        ylab("The number of schooling years") +
        xlab(paste0("Countries in ", input$continent, " continent")) +
        labs(title = paste0("The number of schooling years in countries in ",
                            input$continent))
    }
    plot
  })
  
  # Line chart
  output$q2 <- renderPlot({
    ExpectedYearsOfSchooling(input$femaleMaleSelect, input$femaleMaleYear[1], 
                             input$femaleMaleYear[2], input$femaleMaleCountry)
  })
  
  # Creates the output that will be read in to display the question 3 bar plot.
  output$barPlot <- renderPlot({
    
    # Creates vector that filters expected schooling data by region, with specific nations in each region.
    # Regions were determined by UN classifications.
    developed <-  c("Albania", "Andorra", "Australia", "Austria", "Belarus", "Belgium",
                    "Bosnia and Herzegovina", "Bulgaria", "Canada", "Croatia", "Cyprus", "Czech Republic",
                    "Denmark", "Etonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", 
                    "Ireland", "Israel", "Italy", "Japan", "Latvia", "Liechtenstein", "Lithuania", 
                    "Luxembourg", "Malta", "Montenegro", "Netherlands", "New Zealand", "Norway", "Poland", 
                    "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain",
                    "Sweden", "Switzerland", "Macedonia", "Ukraine", "United Kingdom", "United States")
    
    # Data is filtered by developed vector.
    if (input$nations == "Developed") {
      # The data will be filtered by country in the developed vector.
      region <- filter(data, Country %in% developed)
      # The data is further filtered by years.
      bar_data <- region %>% select(Country, "data" = paste0("X", input$years))
      
      # Outputs the bar plot for Developed nations
      ggplot(bar_data, aes(x = Country, y = data)) + 
        geom_bar(stat = "identity", fill = "#7CA7BE") +
        scale_y_continuous(breaks=c(seq(0, 20, 5)), limits = c(0, 20)) +
        theme(axis.text = element_text(angle = 90, hjust = 1)) +
        xlab("UN Countries from Data") +
        ylab("Expected Years of Schooling") + 
        ggtitle(paste0(input$nations, " Nations Expected Years of Schooling in ",
                       input$years))
      
    } else {
      # All other countries are listed as developing, again, going off the UN classification list.
      # The data will also be filtered by country and year in the developing vector.
      region <- filter(data, !(Country %in% developed))
      bar_data <- region %>% select(Country, "data" = paste0("X", input$years))
      
      # Outputs the bar plot for Developing nations
      ggplot(bar_data, aes(x = Country, y = data)) + 
        geom_bar(stat = "identity", fill = "#7CA7BE") +
        scale_y_continuous(breaks=c(seq(0, 20, 5)), limits = c(0, 20)) +
        theme(axis.text = element_text(angle = 90, hjust = 1, size =4)) +
        xlab("UN Countries from Data") +
        ylab("Expected Years of Schooling") + 
        ggtitle(paste0(input$nations, " Nations Expected Years of Schooling in ",
                       input$years))
    }
  })
  
  output$buttons <- renderUI({
    if (input$main != "home" & input$main != "donate") {
      HTML('
        <div>
          <button class="btn next-btn">Next >></button>
        </div>
        <script>
          $(".next-btn").click(function() {
            nextPage();
          })
        </script>
      ')
    }
  })
}