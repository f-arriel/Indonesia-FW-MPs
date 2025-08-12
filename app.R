library(shiny)
library(mgcv)
library(readr)
library(dplyr)
library(leaflet)

# Load model

gam_model <- readRDS("model.rds")

ui <- fluidPage(
  titlePanel("Microplastic Abundance Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("csvFile", "Upload processed_predictors.csv",
                accept = c(".csv")),
      actionButton("predictBtn", "Predict"),
      hr(),
      downloadButton("downloadData", "Download predictions CSV")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Table", dataTableOutput("predTable")),
        tabPanel("Map", leafletOutput("predMap", height = 600))
      )
    )
  )
)

server <- function(input, output, session) {
  predictors <- reactiveVal(NULL)
  
  # Load CSV 
  observeEvent(input$csvFile, {
    req(input$csvFile)
    df <- read_csv(input$csvFile$datapath)
    predictors(df)
    showNotification("Predictor CSV loaded", type = "message")
  })
  
  # Perform prediction
  predicted_data <- eventReactive(input$predictBtn, {
    req(predictors())
    df <- predictors()
    df$predicted_log_abundance <- predict(gam_model, newdata = df)
    df$predicted_abundance <- exp(df$predicted_log_abundance)
    
    df
  })
  
  # Show table
  output$predTable <- renderDataTable({
    req(predicted_data())
    predicted_data()
  })
  
  # Show map
  output$predMap <- renderLeaflet({
    df <- predicted_data()
    req(df)
    req(all(c("Longitude", "Latitude") %in% colnames(df)))
    
    leaflet(df) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~Longitude,
        lat = ~Latitude,
        radius = ~sqrt(predicted_abundance)*2,
        color = "blue",
        fillOpacity = 0.6,
        popup = ~paste0(
          "Predicted MPs: ", round(predicted_abundance, 2),
          "<br>Longitude: ", Longitude,
          "<br>Latitude: ", Latitude
        )
      )
  })
  
  # Download results CSV
  output$downloadData <- downloadHandler(
    filename = function() {
      paste0("predicted_microplastic_abundance_", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(predicted_data(), file)
    }
  )
}

shinyApp(ui, server)
