#Imports all shapefile documents and converts to sf

filepath1 =" "

#Import the shapefile 
library(rgdal)
dma=readOGR(dsn=filepath1, layer="NatDMA1")
#Source
#https://datablends.us/2021/01/14/a-useful-dma-shapefile-for-tableau-and-alteryx/

library(sf)
dma = st_as_sf(dma)

#Selects for all the DMAs in our region of interest
dma_mini = dma[c(3,4,6,8,10,12,13,16,18,23,25,28,34,35,38,40,45,51,57,66,67,73,76),]

filepath2 = " "

library(rgdal)
NYS=readOGR(dsn=filepath2, layer="Counties_Shoreline")
library(sf)
NYS = st_as_sf(NYS)

#Source
#https://gis.ny.gov/gisdata/inventories/details.cfm?DSID=927

filepath3 = " "

library(rgdal)
PA=readOGR(dsn=filepath3, layer="PaCounty2022_11")
library(sf)
PA = st_as_sf(PA)

#Source
#https://www.pasda.psu.edu/uci/DataSummary.aspx?dataset=24

filepath4 = " "

library(rgdal)
CT=readOGR(dsn=filepath4, layer="tl_2019_09_cousub")
library(sf)
CT = st_as_sf(CT)
CT = subset(CT, NAME != "County subdivisions not defined")

#Source
#https://catalog.data.gov/dataset/tiger-line-shapefile-2019-state-connecticut-current-county-subdivision-state-based




