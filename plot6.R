##  Compare emissions from motor vehicle sources in Baltimore City with emissions 
##  from motor vehicle sources in Los Angeles County, California (fips == 06037). 
##  Which city has seen greater changes over time in motor vehicle emissions?

##  load the libraries we'll be using
library(ggplot2)

##  load the datasets - we'll need both of them
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  get motor-related information with a motor grep
SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

##  Join SSC data with NEI data
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

##  filter on FIPS 24510 (Baltimore) and 06037 (LA)
NEI.motor.baltimore <- NEI.motor[which(NEI.motor$fips == "24510"), ]
NEI.motor.LosAngeles <- NEI.motor[which(NEI.motor$fips == "06037"), ]

##  aggregate Baltimore's data
aggregate.motor.baltimore <- 
  with(NEI.motor.baltimore, aggregate(Emissions, by = list(year), sum))
aggregate.motor.baltimore$group <- 
  rep("Baltimore County", length(aggregate.motor.baltimore[, 1]))

##  aggregate LA's data
aggregate.motor.LosAngeles <- 
  with(NEI.motor.LosAngeles, aggregate(Emissions, by = list(year), sum))
aggregate.motor.LosAngeles$group <- 
  rep("Los Angeles County", length(aggregate.motor.LosAngeles[, 1]))

##  Tie LA & Baltimore together
totalAggregate <- rbind(aggregate.motor.LosAngeles, aggregate.motor.baltimore)
totalAggregate$group <- as.factor(totalAggregate$group)

##  Give the aggregate column names
colnames(totalAggregate) <- c("Year", "Emissions", "Group")

##  plot it, color by city (group)
qplot(Year, Emissions, data = totalAggregate, group = Group, color = Group, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Comparison of Total Emissions: Baltimore vs Los Angeles")