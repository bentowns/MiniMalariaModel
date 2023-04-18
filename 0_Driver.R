#You must be running this project, or code will not work!
#Set working directory
rm(list = ls())
dir0_main <- getwd() #Level 0 folder
#-------------------------------------------------------------------------------
#Directories
#-------------------------------------------------------------------------------
#Level 1
dir1_code <- paste(dir0_main, "Code", sep="/") 
dir1_data <- paste(dir0_main, "Data", sep="/")
dir1_outputs <- paste(dir0_main, "Outputs", sep="/")
dir1data_rainfall <- "../DataCentral/RainfallData"
dir1data_shapefiles <- "../DataCentral/Shapefiles"

#Level 2 directories
dir2data_highLAI <- paste(dir1_data, "HighVegetationLAI", sep="/") 
dir2data_lowLAI <- paste(dir1_data, "LowVegetationLAI", sep="/")
dir2data_temperature <- paste(dir1_data, "Temperature", sep="/")
dir2data_malaria <- paste(dir1_data, "MalariaIncidence", sep="/")
dir2data_netaccess <- paste(dir1_data, "NetAccess", sep="/")
dir2data_TAMSAT <- paste(dir1data_rainfall, "TAMSATMonthly", sep="/")
dir2data_Ghana <- paste(dir1data_shapefiles, "GhanaDistricts", sep="/")
#-------------------------------------------------------------------------------
#Load required packages
#-------------------------------------------------------------------------------
library(raster) #For raster preprocessing
library(sf) #For extraction
library(ncdf4) #For opening climate and LAI files
library(tidyverse) #For any necessary data transformations and plotting
library(exactextractr) #For extracting pixel values
library(parallel) #For parallel computing
library(foreach) #For parallel computing
library(doParallel) #For parallel computing
library(tictoc) #For parallel computing
library(spdep) #For Moran's I
library(gganimate) #For creating gifs
library(lme4) #For mixed models
#-------------------------------------------------------------------------------
#Load parallel
ncores <- detectCores(logical = FALSE)
registerDoParallel(cores=ncores)
#-------------------------------------------------------------------------------
#Read in Datasets
#-------------------------------------------------------------------------------
#Load LAI high vegetation data
loc_highLAI <- paste(dir2data_highLAI, "HighVegetationLAI.nc", sep = "/")
HighVegLAI.nc <- nc_open(loc_highLAI)

#Load LAI low vegetation data
loc_lowLAI <- paste(dir2data_lowLAI, "LowVegetationLAI.nc", sep = "/")
LowVegLAI.nc <- nc_open(loc_lowLAI)

#Load temperature data
loc_temperature <- paste(dir2data_temperature, "GhanaTemperatureData.nc", sep = "/")
Temperature.nc <- nc_open(loc_temperature)

#Load Malaria Incidence rate rasters
MalariaList <- list.files(path = dir2data_malaria,
                           pattern = '.tiff$',
                           all.files = TRUE,
                           full.names = FALSE)
MalariaFullList<- paste(dir2data_malaria, MalariaList, sep = "/")
Malaria <- list()
for (i in 1:10){
  Malaria[[i]] <- raster(MalariaFullList[i])
}

#Load Insecticide Net Access rasters
NetAccessList <- list.files(path = dir2data_netaccess,
                          pattern = '.tiff$',
                          all.files = TRUE,
                          full.names = FALSE)
NetAccessFullList<- paste(dir2data_netaccess, NetAccessList, sep = "/")
NetAccess <- list()
for (i in 1:10){
  NetAccess[[i]] <- raster(NetAccessFullList[i])
}

#Load shapefile of ghana districts
loc_Ghana <- paste(dir2data_Ghana, "gadm41_GHA_2.shp", sep = "/")
Ghana <- st_read(loc_Ghana)

#Load in Monthly TAMSAT
loc_CHIRPSMonth <- paste(dir2data_TAMSAT, "TAMSATMonths_Dec2022.nc", sep = "/")
TAMSATMonth.nc <- nc_open(loc_CHIRPSMonth)