##  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

##  load libraries to use
library(ggplot2)

##  load data to use - we need both datasets so we can join
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  get motor-vehicle-related emissions with a grep on 'motor'
SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

##  join the NEi and SCC datasets
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

##  Filter just on Baltimore City
baltimoreData <- NEI.motor[which(NEI.motor$fips == "24510"), ]

##  Agrgegate by year
baltimoreAggregate <- with(baltimoreData, aggregate(Emissions, by = list(year), 
                                                         sum))
##  plot it
plot(baltimoreAggregate, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Vehicle-Related Emissions in Baltimore City")