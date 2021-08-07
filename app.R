# Load required packages -------------------------------------------------------

library(shiny)
library(shinydashboard)
library(ggplot2)
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
                tableOutput("contents"),
                downloadButton("downloadCsv", "Download as CSV")
        )
        )
      )
    )

# Server ----------------------------------------------------------------------
server <- function(input, output) {
# Render the Histogram in Dashboard tab -----------------------
  output$histogram <- renderPlot({
    WaterPH <- water_potability$ph[seq_len(input$slider)]
    hist(WaterPH)
  })
# Render the Raw table in Raw data tab ---------------------------
  output$contents <- renderTable({
    read.csv(water_potability.csv)
  })
  
  
  
  
  
}






# Run the application -------------------------------------------------------
shinyApp(ui = ui, server = server)
