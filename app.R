# Load required packages -------------------------------------------------------
library(shiny)
library(shinydashboard)
library(ggplot2)
# Load the Data set ------------------------------------------------------------
water_potability <- read.csv(file = 'water_potability.csv')
# Create user interface --------------------------------------------------------
ui <- dashboardPage(
    dashboardHeader(title = "Project1"),
    dashboardSidebar(
      sidebarMenu(
        # Tab 1 -- Dashboard
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        # Tab 2 -- Raw data 
        menuItem("Raw data", tabName = "rawdata", icon = icon("table"))
      )
    ),
    dashboardBody(
      tabItems(
        # Tab 1 body -- Dashboard
        tabItem(tabName = "dashboard",
          fluidRow(
            box(plotOutput("histogram", height = 300)),
            
            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 3276, 1500)
            )
            )
          ),
        # Tab 2 body -- Raw data
        tabItem("rawdata",
                downloadButton("downloadCsv", "Download as CSV"),
                tableOutput("contents")
        )
        )
      )
    )
# Server logistics--------------------------------------------------------------
server <- function(input, output) {
  # Render a Histogram in the Dashboard tab --------------------------
  output$histogram <- renderPlot({
    WaterPH <- water_potability$ph[seq_len(input$slider)]
    hist(WaterPH)
  })
  # Render the csv file in the Raw data tab ---------------------------
  output$contents <- renderTable({
    read.csv(file = 'water_potability.csv')
  })
  # Connect the csv file to the download button -------------------------
  output$downloadCsv <- downloadHandler(
    filename = 'water_potability.csv',
    content = function(file) {
      write.csv(water_potability, file)
    }
  )
  
  
  
}






# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
