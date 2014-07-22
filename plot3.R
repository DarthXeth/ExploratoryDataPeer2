##  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##  which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##  Which have seen increases in emissions from 1999-2008? 
##  Use the ggplot2 plotting system to make a plot answer this question.

##  load libraries that we're using
library(ggplot2)
library(plyr)

##  load data - ~30 seconds on my PC
NEI <- readRDS("summarySCC_PM25.rds")

baltimoreData <- NEI[which(NEI$fips == "24510"), ]


baltimoreData.type <- ddply(baltimoreData, .(type, year), summarize, Emissions = sum(Emissions))
baltimoreData.type$Pollutant_Type <- baltimoreData.type$type

qplot(year, Emissions, data = baltimoreData.type, group = Pollutant_Type, color = Pollutant_Type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in Baltimore by Emission Type 1999 - 2008")