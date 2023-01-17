#Written 2023.01.09
#Sam Epstein
#Generation of LI2

#Set working directory and grab local file paths
library("rstudioapi")
setwd(dirname(getActiveDocumentContext()$path))
source(file.path("local_files_ref.R"))

#Grab 2020 and 2022 counts from voter file
voters20 = read.csv("../data/counts20.csv", header = TRUE)
voters22 = read.csv("../data/counts22.csv", header = TRUE)
colnames(voters20)=c("GEOID", "Tally20")
colnames(voters22)=c("GEOID", "Tally22")

#Grabs geojson file LI1
library(geojsonio)
LI1 <- geojsonsf::geojson_sf("../data/LI1.geojson")

#Merge LI1 and voter data to make LI2
library(dplyr)
LI2 = inner_join(LI1, voters20, by = c("GEOID" = "GEOID"))
LI2 = left_join(LI2, voters22, by = c("GEOID" = "GEOID"))

#Eliminate poor matches
LI2$coverage = LI2$Tally20 / LI2$votes_total
LI2 = subset(LI2, coverage < 5 & coverage > 0.5)

#LI2.geojson is a merged dataset between LI1 and the voter data taken from who voted in CD3/CD4 for 
#Saves data as a Geojson file to desired location
library(sf)
st_write(LI2, "../data/LI2.geojson")

