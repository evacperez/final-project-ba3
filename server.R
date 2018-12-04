## This is the server logic of a Shiny web application. 

## Loading packages
library("shiny")
library("ggplot2")
library("maps")
library("dplyr")
library("countrycode")
library(mapproj)

source("q2.R")

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

## Defining server 
server <- function(input, output, session) {
  ## 
  observeEvent(input$controller, {
    updateTabsetPanel(session, "main",
                      selected = "intro"
    )
    print(input$controller)
  })
  
  ## Home tabPanel Output
  output$home <- renderUI({
    tags$div(
      HTML(homepage_html)
    )
    #session$sendCustomMessage("finishHandler", "finished")
  })
  
  ## Introduction tabPanel Output
  output$intro <- renderText({
    "Jeff"
  })
  
  ## YEARS OF SCHOOLING BY CONTINENTS (QUESTION 1)
  # Creating continent map output
  output$continent_map <- renderPlot({
    map_data <- select(updated_data, region, Continent, paste0("X", input$year))
    world_data <- world_area %>% 
      full_join(map_data, by = "region") 
    
    if (input$continent == "All continents"){
      world_data <- select(world_data, long, lat, group, order, region, 
                           subregion, Continent, paste0("X", input$year))
      colnames(world_data)[8] <- "year"
      
      ggplot(world_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = world_data$year)) +
        scale_fill_gradient(low="mediumpurple1",high="mediumpurple4") +
        labs(title = paste("The number of schooling years in countries of", input$continent),
             fill = "Schooling Years (years)") + coord_quickmap()
    }
    else {
      continent_map_data <- world_data %>%
        filter(Continent == input$continent) 
      colnames(continent_map_data)[8] <- "year"
      
      ggplot(continent_map_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = continent_map_data$year)) +
        scale_fill_gradient(low="darkorange",high="darkorange4") +
        labs(title = paste("The number of schooling years in countries of", input$continent),
             fill = "Schooling Years (years)")  + coord_quickmap()
    }
  })
  
  ## Creating continent bar chart output
  output$continent_bar <- renderPlot({
    if (input$continent == "All continents"){
      world_bar_data <- updated_data %>% 
        select(region, Continent, paste0("X", input$year))
      colnames(world_bar_data)[3] <- "years"
      plot <- ggplot(world_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "darkorange1") +
        geom_text(
          aes(label = years, y = years + 0.05),
          position = position_dodge(0.9),
          vjust = 0,
          color = "grey34",
          size = 2) +  
        scale_y_continuous(breaks=c(seq(0, 15, 1)), limits = c(0, 25)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 5)) +
        ylab("The number of schooling years") +
        xlab("All countries in the world") +
        labs(title = "The number of schooling years in all countries 
                            around the world")
    }
    else {
      continent_bar_data <- updated_data %>% 
        filter(Continent == input$continent) %>%
        select(region, Continent, paste0("X", input$year))
      colnames(continent_bar_data)[3] <- "years"
      plot <- ggplot(continent_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "darkorange1") +
        geom_text(
          aes(label = years, y = years + 0.05),
          position = position_dodge(0.9),
          vjust = 0,
          color = "grey34",
          size = 3) +  
        scale_y_continuous(breaks=c(seq(0, 15, 1)), limits = c(0, 25)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
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
}