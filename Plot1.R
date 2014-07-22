##  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##  Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##  sources for each of the years 1999, 2002, 2005, and 2008.

##  read in our data - this takes ~30 seconds on my PC
NEI <- readRDS("summarySCC_PM25.rds")

##  aggregate by summing emissions of PM2.5 by year
aggregate.data <- with(NEI, aggregate(Emissions, by = list(year), sum))

##  plot the results
plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the United States")