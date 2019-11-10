NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC_table <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

scc_coal <- subset(SCC_table, grepl("Coal", SCC_table$EI.Sector), select = "SCC")
coal_emissions <- subset(NEI, SCC %in% scc_coal$SCC)
coal_emissions_per_year <- with(coal_emissions, tapply(Emissions, year, sum))
plot(x = names(coal_emissions_per_year), y = coal_emissions_per_year, xlab = "Year", ylab = "Total Emissions (Tons)", main="PM2.5 Total Emissions Per Year from Coal-Related Sources")