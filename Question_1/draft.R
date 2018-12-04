
## packages
library("ggplot2")
library("maps")
library("dplyr")
library("countrycode")

## Setting current directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

## original data
data <- read.csv("Expected years of schooling (years).csv", stringsAsFactors = FALSE)

## updated data is the data that have one more column (continent column)
updated_data <- data %>% 
  mutate(Continent = countrycode(data$Country, 'country.name', 'continent')) %>%
  select(Country, Continent, X1990)
colnames(updated_data)[1] <- "region"
updated_data$region <- gsub('\\s+', '', updated_data$region)
updated_data$region <- paste0(substring(updated_data$region, 1, 1), 
                              tolower(substring(updated_data$region, 2)))

# Bar chart data
asia_data <- updated_data %>% filter(Continent == "Asia")


## Bar Chart
bar <- ggplot(asia_data, aes(x = region, y = X1990)) +
  geom_bar(stat = "identity", fill = "darkorange1", color = "black") +
  scale_y_continuous(breaks=c(seq(0, 15, 1)), limits = c(0, 15)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("The number of schooling years") +
  xlab("Countries in Asia continent") + 
  labs(title = "The number of schooling years in countries of Asia continent")

  
## Map of Asia
## World data
world_area <- map_data("world")
world_continent_area <- world_area %>% 
  mutate(Continent = countrycode(world_area$region, 'country.name', 'continent'))

## Asia data
asia_years <- asia_data %>% select(region, X1990)
asia_continent <- world_continent_area %>%
  filter(Continent == "Asia") %>%
  full_join(asia_years, by = "region")

## Asia map
asia_map <- ggplot(data = asia_continent, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = asia_continent$X1990)) +
  geom_label(label = asia_continent$region) +
  scale_fill_gradient(low="darkorange",high="darkorange4") +
  labs(title = "The number of schooling years in countries of Asia continent",
       fill = "Schooling Years (years)") 


## Map of world
## World data
world_area <- map_data("world")
world_continent_area <- world_area %>% 
  mutate(continent = countrycode(world_area$region, 'country.name', 'continent')) %>%
  full_join(updated_data, by = "region")

## World map
world_map <- ggplot(data = world_continent_area, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = world_continent_area$X1990), color = "White") +
  scale_fill_gradient(low="mediumpurple1",high="mediumpurple4") +
  labs(title = "The number of schooling years in countries of all continent",
       fill = "Schooling Years (years)") 
  
  