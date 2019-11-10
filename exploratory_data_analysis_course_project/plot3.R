library(dplyr)
library(ggplot2)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

baltimore_emissions <- subset(NEI, fips == "24510")
baltimore_emissions_per_type_year <- baltimore_emissions %>% group_by(year, type) %>% summarize(sum(Emissions))

ggplot(baltimore_emissions_per_type_year, aes(year, `sum(Emissions)`)) + geom_point() + 
  facet_grid(facets = .~type) + 
  labs(title="PM2.5 Total Emissions Per Year and Type in Baltimore", x="Year", y="Total Emissions(Tons)")