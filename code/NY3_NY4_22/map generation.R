#2023.01.09
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

#Plot of 2020 election results
library(ggplot2)
ggplot()+
  geom_sf(data = LI2, aes(fill = pct_dem_lead))+
  scale_fill_gradient2(low = "red", mid = "white", high = "blue")+
  geom_sf(data=CD, alpha = 0, aes(color = DISTRICT), size = 3)+
  ylim(40.58, 40.91)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  labs(fill = "% Biden Lead '20")+
  labs(color = "'22 CD")+
  ggtitle("2020 presidential elections results by eleciton district in new CD-3 and CD-4")

ggsave("../images/2020results.jpg", last_plot(), width = 7, height = 6, dpi = 600)

#Calculation of Turnover from 2020 to 2022
LI2$Turnover = LI2$Tally22 * 100 / LI2$Tally20

#Plot of turnover
library(ggplot2)
ggplot()+
  geom_sf(data = LI2, aes(fill = Turnover))+
  scale_fill_gradient(low = "purple", high = "yellow", breaks = c(25, 50, 75, 100), limits = c(25,100))+
  geom_sf(data=CD, alpha = 0, aes(color = DISTRICT), size = 3)+
  ylim(40.58, 40.91)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  labs(fill = "'22 voters / '20 voters (%)")+
  labs(color = "'22 CD")+
  ggtitle("2022 turnout by eleciton district in new CD-3 and CD-4")

ggsave("../images/2022_turnout.jpg", last_plot(), width = 8, height = 6, dpi = 600)

#Correlation graph
ggplot()+
  geom_point(data = LI2, aes(x= Turnover, y = pct_dem_lead))+
  xlim(25,100)+
  xlab("Turnout (% of '20 Voters that voted in '22)")+
  ylab("Partisanship (% Biden lead in '20)")+
  theme_light()+
  ggtitle("Relationship between '22 voter turnout and '20 district partisanship")+
  annotate("text", x=50, y=-50, label=paste("r = ", round(cor(LI2$Turnover, LI2$pct_dem_lead, use = "pairwise.complete.obs"), 2), sep=""), size = 8)+
  theme(axis.text.x = element_text(size = 14))+
  theme(axis.text.y = element_text(size = 14))

ggsave("../images/correlation.jpg", last_plot(), width = 10, height = 6, dpi = 600)




