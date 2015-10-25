library(shiny)
require(rCharts)
options(RCHART_LIB = 'highcharts')
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Graduates by Country per Year"),
    # Select box for Year
    sidebarPanel(
      selectInput(inputId = "year",
                  label = "Select year to compare countries",
                  choices = c("2008", "2009","2010","2011","2012","All"),
                  selected = "All")
    ),
    # Two line charts
    mainPanel(
      showOutput("linesValues", "highcharts"),
      showOutput("linesPercentage", "highcharts")
    )
  )
)