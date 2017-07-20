#This script creates a line plot to answer the question:
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Choice is to use base plotting system
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
e <- grepl("Mobile.*Vehicles", SCC$EI.Sector)
SCCMV <- as.character(subset(SCC, e)$SCC)
rm(e, SCC)
NEIbalt <- subset(NEI, NEI$fips=="24510")
NEIbalt$year <- as.factor(NEIbalt$year)
rm(NEI)
EMsum <- vector("numeric", 4)
a <- 1
for(i in levels(NEIbalt$year)){
  EMsum[a] <- sum(NEIbalt$Emissions[NEIbalt$year==i & NEIbalt$SCC %in% SCCMV])
  a <- a + 1
}
rm(a, i, SCCMV)
png(filename = "plot5.png")
plot(levels(NEIbalt$year), EMsum, type = "b", xaxp = c(1999, 2008, 3) ,main = "Total Motor Vehicle Emissions in Baltimore", xlab = "Year", ylab = "Emissions in Tons")
dev.off()
rm(EMsum, NEIbalt)