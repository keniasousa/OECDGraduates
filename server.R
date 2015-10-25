require(rCharts)
library(shiny)
library(ggplot2)
library(dplyr)

# Data on graduates
graduates <- read.csv("./Data/RGRADAGE_21102015100250897.csv", sep = ",", na.strings=c("NA",""))  
# Subset the dataset to the concerned variables and year 2008 until 2012
graduatesQty <- subset(graduates, select=c(COUNTRY,Country,YEAR,Value))
graduates2008Til12 <<- subset(graduatesQty, YEAR>= 2008)

# Data on population
population <- read.csv("./Data/ALFS_POP_VITAL_21102015112751678.csv", sep = ",", na.strings=c("NA",""))  
# Subset the dataset to the concerned variables and year 2008 until 2012
populationStats <- subset(population, select=c(LOCATION,Country,SUBJECT,Subject,TIME,Value))
populationStatsTotal <- subset(populationStats, SUBJECT== "YPTTTTL1_ST")
populationStats2008Til12 <- subset(populationStatsTotal, TIME>= 2008 & TIME <=2012)
# Adjust to get same decimals as in graduates dataset
populationStats2008Til12$Value100 <- populationStats2008Til12$Value *1000

# Subset countries in common for list of graduates and population
populationAndGraduates <- merge(populationStats2008Til12,graduates2008Til12,by.x = c("LOCATION","TIME"),by.y = c("COUNTRY","YEAR"))
# Add percentage for proportionality in analysis of graduates
populationAndGraduates$Percentage <- (populationAndGraduates$Value.y *100) / populationAndGraduates$Value100

shinyServer(
  function(input, output) {
    # First chart
    output$linesValues <- renderChart2({
      YEARSelected = input$year
      if (YEARSelected != "All"){
        graduatesYear <- subset(graduates2008Til12, YEAR == YEARSelected)
      }
      else{
        graduatesYear <- graduates2008Til12
      }
      h1 <- hPlot(x = "COUNTRY", y = "Value", group = "YEAR", data = graduatesYear,type = 'line')
      h1$title(text = 'Quantity of graduates')
      return(h1)  
    })
   # Second chart
    output$linesPercentage = renderChart2({
      YEARSelected = input$year
      if (YEARSelected != "All"){
        graduatesYear <- subset(populationAndGraduates, TIME == YEARSelected)
      }
      else{
        graduatesYear <- populationAndGraduates
      }
      h2 <- hPlot(x = "LOCATION", y = "Percentage", group = "TIME", data = graduatesYear,type = 'line')
      h2$title(text = 'Percentage of graduates')
      return(h2) 
    })
  })