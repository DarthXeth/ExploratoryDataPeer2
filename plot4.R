##  Across the United States, how have emissions from coal combustion-related sources 
##  changed from 1999-2008?

##  load libraries
library(lattice)
library(plyr)

##  load data sets - we need both in this model
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  Get goal-related fields with a coal grep
coalSet <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coalSet <- SCC[coalSet, ]
SCC.identifiers <- as.character(coalSet$SCC)

##  join the coal SCC set to the national NEI set
NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

##  Aggregate coal-related emissions by year
aggregate.coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

##  Now plot it
plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
     xlim = c(1999, 2008))

