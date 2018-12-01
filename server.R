
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
  
  output$intro <- renderText({
    "Jeff"
  })
}