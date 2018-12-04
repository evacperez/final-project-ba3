## This is the server logic of a Shiny web application. 
## server.R of years of schooling by continents


## Loading packages
library("shiny")
library("ggplot2")
library("maps")
library("dplyr")
library("countrycode")


## Setting current directory
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Documents/info201/Question_1")


## Reading the data 
# Original data
data <- read.csv("data.csv", stringsAsFactors = FALSE)


# Updated data: a new column of Continents, select column: Country and Continent
updated_data <- data %>% 
  mutate(Continent = countrycode(data$Country, 'country.name', 'continent')) 
colnames(updated_data)[2] <- "region"
updated_data$region <- gsub('\\s+', '', updated_data$region)
updated_data$region <- paste0(substring(updated_data$region, 1, 1), 
                              tolower(substring(updated_data$region, 2)))
# Data for world map
world_area <- map_data("world")


## Defining server 
shinyServer(function(input, output) {
  
  ## Creating continent map output
  output$continent_map <- renderPlot({
    
    ## Creating the common data
    map_data <- select(updated_data, region, Continent, paste0("X", input$year))
    world_data <- world_area %>% 
      full_join(map_data, by = "region") 
    
    # if-else to filter all continents map or a specific contient map
    if (input$continent == "All continents"){
      # Creating data for world map
      world_data <- select(world_data, long, lat, group, order, region, 
                           subregion, Continent, paste0("X", input$year))
      colnames(world_data)[8] <- "year"
      
      # Creating world map
      ggplot(world_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = world_data$year)) +
        scale_fill_gradient(low="mediumpurple1",high="mediumpurple4") +
      ggtitle(paste("The number of schooling years in countries of", input$continent)) +
      labs(fill = "Schooling Years (years)") 
    }
    else {
      # Create data for the specific continent
      continent_map_data <- world_data %>%
        filter(Continent == input$continent) 
      colnames(continent_map_data)[8] <- "year"
      # Creating continent map
      ggplot(continent_map_data, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill = continent_map_data$year)) +
        scale_fill_gradient(low="darkorange",high="darkorange4") +
        labs(title = paste("The number of schooling years in countries of", input$continent),
             fill = "Schooling Years (years)") 
    }
  })
  
  
  ## Creating continent bar chart output
  output$continent_bar <- renderPlot({
    
    # if-else to filter all continents or a specific contient bar chart
    if (input$continent == "All continents"){
      # Create data for world bar
      world_bar_data <- updated_data %>% 
        select(region, Continent, paste0("X", input$year))
      colnames(world_bar_data)[3] <- "years"
      # Creating world bar chart
      plot <- ggplot(world_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "darkorange1") +
        scale_y_continuous(breaks=c(seq(0, 15, 1)), limits = c(0, 15)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ylab("The number of schooling years") +
        xlab("All countries in the world") 
    }
    else {
      # Create data for continent bar chart
      continent_bar_data <- updated_data %>% 
        filter(Continent == input$continent) %>%
        select(region, Continent, paste0("X", input$year))
      colnames(continent_bar_data)[3] <- "years"
      # Creating continent bar chart
      plot <- ggplot(continent_bar_data, aes(x = region, y = years)) +
        geom_bar(stat = "identity", fill = "darkorange1") +
        geom_text(
          aes(label = years, y = years + 0.05),
          position = position_dodge(0.9),
          vjust = 0,
          color = "grey47")+       
        scale_y_continuous(breaks=c(seq(0, 15, 1)), limits = c(0, 15)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ylab("The number of schooling years") +
        xlab(paste0("Countries in", input$continent, "continent")) 
    }
    plot
  })
})

    

