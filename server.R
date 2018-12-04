source("q2.R")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

file_name <- "www/carousel.html"
homepage_html <- readChar(file_name, file.info(file_name)$size)

server <- function(input, output, session) {
  
  observeEvent(input$controller, {
    updateTabsetPanel(session, "main",
                      selected = "intro"
    )
    print(input$controller)
  })
  
  output$home <- renderUI({
    tags$div(
      HTML(homepage_html)
    )
    #session$sendCustomMessage("finishHandler", "finished")
  })
  
  output$create <- renderText({
    "Project Creators: Eva Perez, Jeff Zhang, Joselly Anne Ongoco, Phuong Le"
  })
  
  output$intro <- renderText({
    "An Introduction to our Project..."
  })
  
  output$q2 <- renderPlot({
    ExpectedYearsOfSchooling(input$femaleMaleSelect, input$femaleMaleYear[1], input$femaleMaleYear[2], input$femaleMaleCountry)
  })
}