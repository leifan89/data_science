NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

baltimore_emissions <- subset(NEI, fips == "24510")
yearly_emissions_total <- with(baltimore_emissions, tapply(Emissions, year, sum))
plot(x = names(yearly_emissions_total), y = yearly_emissions_total, xlab = "Year", ylab = "Total Emissions (Tons)", main="PM2.5 Total Emissions Per Year in Baltimore")

