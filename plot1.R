#This script creates a line plot to answer the question:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Requirement is to use base plotting system
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)
EMsum <- vector("numeric", 4)
a <- 1
for(i in levels(NEI$year)){
  EMsum[a] <- sum(NEI$Emissions[NEI$year==i])
  a <- a + 1
}
rm(a, i)
png(filename = "plot1.png")
plot(levels(NEI$year), EMsum, type = "b", xaxp = c(1999, 2008, 3), main = "Total Emissions in the United States", xlab = "Year", ylab = "Emissions in Tons")
dev.off()
rm(EMsum, NEI)