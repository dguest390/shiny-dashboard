# Load required packages -------------------------------------------------------
library(shiny)
library(shinydashboard)
library(ggplot2)
require(scales)
# Load the Data set ------------------------------------------------------------
water_potability <- read.csv(file = 'water_potability.csv')
# Create user interface --------------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(title = "Shiny Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      # Tab 1 -- Dashboard -----------------------------------------------------
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      # Tab 2 -- Raw data ------------------------------------------------------
      menuItem("Raw data", tabName = "rawdata", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      # Tab 1 body -- Dashboard ------------------------------------------------
      tabItem(tabName = "dashboard",
              fluidRow(
                # Histogram graph ----------------------------------------------
                box(plotOutput("histogram", height = 219)),
                # Slider for Histogram -----------------------------------------
                box(
                  title = "Slider for Histogram",
                  varSelectInput("variable_histogram", "Variable:",
                                 water_potability),
                  sliderInput("slider_bins","Number of bins:",1,60,30)
                )
              ),
              fluidRow(
                # Scatter plot graph -------------------------------------------
                box(plotOutput("scatterplot")),
                # Scatter plot input variables ---------------------------------
                box(
                  title = "Select variables to display",
                  varSelectInput("variable_for_x", "Variable for X:", 
                                 water_potability),
                  varSelectInput("variable_for_y", "Variable for Y:",
                                 water_potability, selected = "Hardness")
                )
              ),
              fluidRow(
                # Dot plot graph -----------------------------------------------
                box(
                  title = "Variable VS Potability",
                  plotOutput("dotplot")
                ),
                # Dot plot input variables -------------------------------------
                box(
                  title = "Select a Variable",
                  varSelectInput("variable_potability", "Variable for Y",
                                 water_potability)
                )
              )# end of fluid row
      ),
      # Tab 2 body -- Raw data -------------------------------------------------
      tabItem("rawdata",
              downloadButton("downloadCsv", "Download as CSV"),
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("contents")
      )
    )
  )
)
# Server logistics--------------------------------------------------------------
server <- function(input, output) {
  # Render a Histogram in the Dashboard tab ------------------------------------
  output$histogram <- renderPlot({
    ggplot(data = water_potability) + 
      aes(x = !!input$variable_histogram, y = ..density..) + 
      geom_histogram(color="white",alpha=.5,bins=input$slider_bins) + 
      scale_y_continuous(labels = percent) +
      theme_bw() + 
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank()) +
      labs(title="Histogram",y="percent")
  })
  # Render a Scatter plot ------------------------------------------------------
  output$scatterplot <- renderPlot({
    ggplot(water_potability, 
      aes(x=!!input$variable_for_x, y=!!input$variable_for_y)) + 
      geom_point(size = 1, shape = 18) +
      labs(title = "Scatter plot")
  })
  # Render a Dot plot ----------------------------------------------------------
  output$dotplot <- renderPlot({
    ggplot(water_potability, aes(x=Potability, 
      y=!!input$variable_potability)) +
      geom_jitter(width = 0.25, ) 
  })
  
  # Render the csv file in the Raw data tab ------------------------------------
  output$contents <- renderPrint({
    orig <- options(width = 1000)
    print(tail(water_potability, input$maxrows), row.names = FALSE)
    options(orig)
  })
  # Connect the csv file to the download button --------------------------------
  output$downloadCsv <- downloadHandler(
    filename = 'water_potability.csv',
    content = function(file) {
      write.csv(water_potability, file)
    }
  )
  
  
  
}






# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)
