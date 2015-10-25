library(shiny)
require(rCharts)
options(RCHART_LIB = 'highcharts')
shinyUI(
  fluidPage(
    # Application title
    headerPanel("Graduates by Country per Year"),
    # Select box for Year
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "year",
                    label = "Select year to compare countries",
                    choices = c("2008", "2009","2010","2011","2012","All"),
                    selected = "All")
      ),
    # Two line charts
      mainPanel(
        tabsetPanel(
          tabPanel("Plots", showOutput("linesValues", "highcharts"),
                   showOutput("linesPercentage", "highcharts")), 
          tabPanel("User Guide", 
                   #verbatimTextOutput("summary")
                   h3("User Guide"),
                   p(HTML("This is a Shiny application that shows data from the Organisation for Economic Co-operation and Development (OECD) concerning graduates and population per Country and Year.")),
                   p(HTML("OCDE is an international economic organisation of 34 countries, it publishes statistics on a wide number of subjects.")),
                   p(HTML("This application shows two charts:")),
                   p(HTML("The first chart shows the quantity of graduates per country and year.")),
                   p(HTML("The second chart shows the percentage of graduates per country and year.")),
                   p(HTML("At first, it presents the two charts for all the years from 2008 until 2012. Then, it dynamically updates the two charts based on the user selection of the year.")),
                   p(HTML("You can pass the mouse over the lines to see the country, year and value.")),
                   p(HTML("The percentage is calculated based on the number of graduates and population. Population is needed to provide proportionality, a corrective measure to give fairness to the statistics when analysing the countries with more graduates. For instance, with quantity, the USA has a high number of graduates due to its large population. But with propotionality, we see that Ireland, Finland and Austria have a higher proportion of graduates than the USA, to name a few.")),
                   p(HTML("More technical information and the source code are available on <a href='https://github.com/keniasousa/OECDGraduates' target='_blank'>my GitHub Repo for OECD Graduates</a>.")),
                   p(HTML("The original file from OECD for graduates is on the following link: <a href='http://stats.oecd.org/viewhtml.aspx?datasetcode=RGRADAGE&lang=en' target='_blank'>OECD Graduates </a>.")),
                   p(HTML("The original file from OECD for Population is on the following link:  <a href='http://stats.oecd.org/viewhtml.aspx?datasetcode=ALFS_POP_VITAL&lang=en' target='_blank'>OECD Population</a>."))
                   )
        )
      )
    )
  )
)