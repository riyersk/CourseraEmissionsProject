#This script creates a pair of line plots to answer the question:
#Comparing Baltimore City with Los Angeles, which city has seen greater changes in motor vehicle emissions over time?
#Choice is to use ggplot2 plotting system
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
e <- grepl("Mobile.*Vehicles", SCC$EI.Sector)
SCCMV <- as.character(subset(SCC, e)$SCC)
rm(e, SCC)
NEIbaltLA <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")
rm(NEI)
NEIbaltLA$year <- as.factor(NEIbaltLA$year)
NEIbaltLA$fips <- as.factor(NEIbaltLA$fips)
dframe <- matrix(data = NA, nrow = 8, ncol = 3)
a <- 1
for(i in levels(NEIbaltLA$year)){
  for(j in levels(NEIbaltLA$fips)){
    dframe[a,1] <- sum(NEIbaltLA$Emissions[NEIbaltLA$year == i & NEIbaltLA$fips == j & NEIbaltLA$SCC %in% SCCMV])
    dframe[a,2] <- j
    dframe[a,3] <- i
    a <- a + 1
  }
}
rm(a, i, j, NEIbaltLA, SCCMV)
dframe <- as.data.frame(dframe)
colnames(dframe) <- c("Emissions", "fips", "Year")
dframe$Year <- as.factor(dframe$Year)
dframe$fips <- as.factor(dframe$fips)
dframe$fips <- gsub("24510", "Baltimore", dframe$fips)
dframe$fips <- gsub("06037", "Los Angeles", dframe$fips)
dframe$Emissions <- as.numeric(as.character(dframe$Emissions))
png(filename = "plot6.png")
print(qplot(Year, Emissions, data = dframe, group=1, main = "Motor Vehicle Emissions in Baltimore and Los Angeles", ylab = "Emissions in Tons") + facet_grid(fips~., scales = "free_y") + geom_line())
dev.off()
rm(dframe)