NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC_table <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

scc_vehicles <- subset(SCC_table, grepl("Vehicle", SCC_table$EI.Sector), select = "SCC")
baltimore_emissions <- subset(NEI, fips == "24510")
vehicle_emissions <- subset(baltimore_emissions, SCC %in% scc_vehicles$SCC)
vehicle_emissions_per_year <- with(vehicle_emissions, tapply(Emissions, year, sum))
plot(x = names(vehicle_emissions_per_year), y = vehicle_emissions_per_year, xlab = "Year", ylab = "Total Emissions (Tons)", main="PM2.5 Total Emissions Per Year from Vehicle-Related Sources in Baltimore")