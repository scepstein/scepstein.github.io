#2023.01.16
#Written by Sam Epstein 

#Set working directory and grab local file paths
library("rstudioapi")
setwd(dirname(getActiveDocumentContext()$path))
source(file.path("local_files_ref.R"))

#Grabs geojson file LI2
library(geojsonio)
LI2 <- geojsonsf::geojson_sf("../data/LI2.geojson")

#Imports CD Shapefiles 
library(rgdal)
CD=readOGR(dsn="../data/CON22_June_03_2022", layer="CON22_June_03_2022")
library(sf)
CD = st_as_sf(CD)
CD = subset(CD, DISTRICT == 3 | DISTRICT == 4)
CD$DISTRICT = as.factor(CD$DISTRICT)

#Calculation of Turnover from 2020 to 2022
LI2$Turnover = LI2$Tally22 * 100 / LI2$Tally20

#Plot of turnover
library(ggplot2)
ggplot()+
  geom_sf(data = LI2, aes(fill = Turnover))+
  scale_fill_gradient(low = "purple", high = "yellow", breaks = c(25, 50, 75, 100), limits = c(25,100))+
  geom_sf(data=CD, alpha = 0, aes(color = DISTRICT), size = 3)+
  ylim(40.58, 40.91)+
  theme_void()+
  theme(legend.position = "none")

ggsave("../images/icon.jpg", last_plot(), width = 6, height = 6, dpi = 600)  
