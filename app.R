# Load required packages -------------------------------------------------------
library(shiny)
library(shinydashboard)
library(ggplot2)
require(scales)
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
              sliderInput("slider", "Number of observations:", 1, 3276, 1500),
              sliderInput("slider_bins","Number of bins:",1,60,30)
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
    WaterPH <- as.data.frame(water_potability$ph[1:input$slider])
    ggplot(data = WaterPH) + aes(x = WaterPH[,1], y = ..density..) + 
      geom_histogram(color="white",alpha=.5,bins=input$slider_bins) + 
      scale_x_continuous("pH", c(0:14)) +
      scale_y_continuous(labels = percent) +
      theme_bw() + 
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
      labs(title="Histogram",y="percent")
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
