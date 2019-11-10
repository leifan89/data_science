NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

yearly_emissions_total <- with(NEI, tapply(Emissions, year, sum))
plot(x = names(yearly_emissions_total), y = yearly_emissions_total, xlab = "Year", ylab = "Total Emissions (Tons)", main="PM2.5 Total Emissions Per Year")

