NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC_table <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

scc_vehicles <- subset(SCC_table, grepl("Vehicle", SCC_table$EI.Sector), select = "SCC")
baltimore_emissions <- subset(NEI, fips == "24510")
baltimore_vehicle_emissions <- subset(baltimore_emissions, SCC %in% scc_vehicles$SCC)
baltimore_vehicle_emissions_per_year <- with(baltimore_vehicle_emissions, tapply(Emissions, year, sum))

la_emissions <- subset(NEI, fips == "06037")
la_vehicle_emissions <- subset(la_emissions, SCC %in% scc_vehicles$SCC)
la_vehicle_emissions_per_year <- with(la_vehicle_emissions, tapply(Emissions, year, sum))

plot(x = names(baltimore_vehicle_emissions_per_year), y = baltimore_vehicle_emissions_per_year, ylim = range(la_vehicle_emissions_per_year, baltimore_vehicle_emissions_per_year), xlab = "Year", ylab = "Total Emissions (Tons)", main="PM2.5 Total Emissions Per Year from Vehicle-Related Sources in Baltimore vs. LA", pch=19)
points(x = names(la_vehicle_emissions_per_year), y = la_vehicle_emissions_per_year, pch=2)
legend("right", legend =c("Baltimore", "LA"), pch=c(19, 2))
