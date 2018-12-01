library(shiny)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://use.fontawesome.com/releases/v5.5.0/css/all.css"),
    tags$script(src = "index.js", type = "text/javascript")
  ),
  
  titlePanel("Data Explorer"),
  tabsetPanel(id = "main",
    tabPanel(title = "Welcome!", value = "home", htmlOutput("home")),
    tabPanel(title = "Introduction", value = "intro", textOutput("intro")),
    tabPanel(title = "Key Question #1", value = "q1")
  ),
  
  tags$br()
  
)