library(ggplot2)
library(dplyr)
library(reshape2)
yearStart <- 1990
yearEnd <- 2017
femaleMaleCountry <- "Canada"
ExpectedYearsOfSchooling <- function(femaleMaleSelect, yearStart, yearEnd, femaleMaleCountry) {
  data <- NULL
  # Select correct dataset
  if (femaleMaleSelect == "Both Female and Male") {
    data <- read.csv("./Data/Expected years of schooling (years).csv", stringsAsFactors = FALSE)
  } else if (femaleMaleSelect == "Female") {
    data <- read.csv("./Data/Expected years of schooling, female (years).csv", stringsAsFactors = FALSE)
  } else {
    data <- read.csv("./Data/Expected years of schooling, male (years).csv", stringsAsFactors = FALSE)
  }
  # Eliminate nulls
  df <- na.omit(data)
  # Remove ranks (we don't want them)
  df$HDI.Rank..2017.<- NULL
  # Remove 'X' from column names for years
  if (femaleMaleSelect == "Both Female and Male") {
    names(df)[2:29] <- substring(names(df)[2:29],2,5)
  } else {
    names(df)[2:12] <- substring(names(df)[2:12],2,5)
  }
  # Remove trailing and leading whitespace from Country names
  df$Country <- trimws(df$Country)
  
  # Filter for correct country
  df <- df %>% filter(Country == femaleMaleCountry)
  # Melt the years+values to Country
  melt <- melt(df, id = "Country")
  # Convert factors to numerics for filtering
  melt$variable <-as.numeric(as.character(melt$variable))
  # Filter for correct year range
  melt <- melt %>% filter(variable >= yearStart & variable <= yearEnd)
  
  ### Graph and return the data
  ## Values
  ## - Country: place
  ## - variable: year
  ## - value: numeric
  return(ggplot(melt, aes(x = factor(variable), y = value, color = Country, group = Country, show.legend = FALSE)) +       
    geom_line(show.legend = FALSE) + geom_point(show.legend = FALSE) +
      ggtitle("Expected Years of Schooling of Different Gender Demographics in Chosen Country") +
      geom_line(color = "#4b2e83", alpha = 0.75) +
      geom_point(color = "#b7a57a", alpha = 0.75) +
      labs(x = "Selected Year(s)", y = "Years of Schooling") +
      theme(plot.title = element_text(color="#666666", face="bold", hjust=0.5)) +
      theme(axis.title = element_text(color="#666666", face="bold")))
}