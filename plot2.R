##  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) 
##  from 1999 to 2008? Use the base plotting system to make a plot answering this question.

##  read in our data - this takes ~30 seconds on my PC
NEI <- readRDS("summarySCC_PM25.rds")

##  filter on baltimore (FIPS == 24510)
baltimore <- NEI[which(NEI$fips == "24510"), ]

##  aggregate Baltimore emissions by year
totalShitByYear <- with(baltimore, aggregate(Emissions, by = list(year), sum))

##  name columns something palatable
colnames(totalShitByYear) <- c("Emissions", "Year")

##  Plot it
plot(totalShitByYear, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions for Baltimore 1999 - 2008", xlim = c(1999, 2008))

##  Plot it
plot(totalShitByYear, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions for Baltimore 1999 - 2008")