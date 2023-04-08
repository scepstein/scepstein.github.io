#Sam Epstein
#Written 2023.01.09
#The following code is used to generate nassau1.geojson from source file from NYT repository 
#Data Source: https://github.com/TheUpshot/presidential-precinct-map-2020

#Set working directory and grab local file paths
library("rstudioapi")
setwd(dirname(getActiveDocumentContext()$path))
source(file.path("local_files_ref.R"))

#Pulls all data from the Geojson file and converts it to R data frame
library(geojsonio)
data <- geojsonsf::geojson_sf(localfile_path1)

#Creates a subset of the full data set with the FIPS county code for relevant counties
library(stringr)
nassau=data[str_detect(data$GEOID, "36059-"), ] 
suffolk=data[str_detect(data$GEOID, "36103-"), ] 
queens = data[str_detect(data$GEOID, "36081-"), ] 

rm(data)

data = rbind(nassau, queens, suffolk)
rm(nassau, queens, suffolk)

#LI1.geojson is a subset of the orginial national NYT geojson file, with just precincts from Nassau County, Queens and Suffolk, NY
#Saves data as a Geojson file to desired location
library(sf)
st_write(data, "../data/LI1.geojson")

