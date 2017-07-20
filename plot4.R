#This script creates a line plot to answer the question:
#Across the U.S., how have emissions from coal combustion-related sources changed from 1999-2008?
#Choice is to use base plotting system
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- as.factor(NEI$year)
SCC <- readRDS("Source_Classification_Code.rds")
e <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
e[477] = TRUE #These correspond to SCC codes which correspond to coal combustion
e[478] = TRUE #but don't fit the pattern "Fuel Comb.*Coal" in their EI Sector
SCCoal <- as.character(subset(SCC, e)$SCC)
rm(e, SCC)
EMsum <- vector("numeric", 4)
a <- 1
for(i in levels(NEI$year)){
  EMsum[a] <- sum(NEI$Emissions[NEI$year==i & NEI$SCC %in% SCCoal])
  a <- a + 1
}
rm(a, i, SCCoal)
png(filename = "plot4.png")
plot(levels(NEI$year), EMsum, type = "b", xaxp = c(1999, 2008, 3), main = "Total Coal Combustion Emissions Across the U.S.", xlab = "Year", ylab = "Emissions in Tons")
dev.off()
rm(EMsum, NEI)