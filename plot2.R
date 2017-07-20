#This script creates a line plot to answer the question:
#Have total emissions from PM2.5 decreased in Baltimore City, Maryland from 1999 to 2008?
#Requirement is to use base plotting system
NEI <- readRDS("summarySCC_PM25.rds")
NEIbalt <- subset(NEI, NEI$fips == "24510")
rm(NEI)
NEIbalt$year <- as.factor(NEIbalt$year)
EMsum <- vector("numeric", 4)
a <- 1
for(i in levels(NEIbalt$year)){
  EMsum[a] <- sum(NEIbalt$Emissions[NEIbalt$year==i])
  a <- a + 1
}
rm(a, i)
png(filename = "plot2.png")
plot(levels(NEIbalt$year), EMsum, xaxp= c(1999, 2008, 3), type = "b", main = "Total Emissions in Baltimore", xlab = "Year", ylab = "Emissions in Tons")
dev.off()
rm(EMsum, NEIbalt)