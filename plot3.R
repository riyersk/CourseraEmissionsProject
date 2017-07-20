#This script creates a set of line plots to answer the question:
#Of the 4 types of sources indicated by the type variable, which sources have seen decreases in emissions in Baltimore City from 1999-2008?
#Which sources have seen increases in emissions from 1999-2008? (Assuming also in Baltimore City)
#Requirement is to use ggplot2 plotting system
NEI <- readRDS("summarySCC_PM25.rds")
library(ggplot2)
NEIbalt <- subset(NEI, NEI$fips=="24510") #Subset the group to Baltimore only
rm(NEI)
NEIbalt$year <- as.factor(NEIbalt$year)
NEIbalt$type <- as.factor(NEIbalt$type)
dframe <- matrix(data = NA, nrow = 16, ncol = 3)  #Fill this with sum of all emissions by type and year
a <- 1
for(j in levels(NEIbalt$year)){
  for(i in levels(NEIbalt$type)){
    dframe[a,1] <- sum(NEIbalt$Emissions[NEIbalt$year==j & NEIbalt$type == i])
    dframe[a, 2] <- i
    dframe[a, 3] <- j
    a <- a + 1
  }
}
rm(a, i, j, NEIbalt)
dframe <- as.data.frame(dframe)
colnames(dframe) = c("Emissions", "Type", "Year")
dframe$Year <- as.factor(dframe$Year)
dframe$Type <- as.factor(dframe$Type)
dframe$Emissions <- as.numeric(as.character(dframe$Emissions))
png(filename = "plot3.png")
print(qplot(Year, Emissions, group = 1, data = dframe, main = "Emissions in Baltimore by Type", ylab = "Emissions in Tons") + facet_grid(Type~., scales = "free_y") + geom_line())
dev.off()
rm(dframe)