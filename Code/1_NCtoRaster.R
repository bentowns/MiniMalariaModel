#-------------------------------------------------------------------------------
#Convert the netCDF files to rasterlayers
#-------------------------------------------------------------------------------
#Load driver
source("0_Driver.R")
#-------------------------------------------------------------------------------
#Create empty lists
HighVegLAI.raster <- list()
LowVegLAI.raster <- list()
Temperature.raster <- list()
TAMSATMonth.raster <- list()
#-------------------------------------------------------------------------------
#Create Rasters for High Vegetation LAI
#-------------------------------------------------------------------------------
#Get variables
lon <- ncvar_get(HighVegLAI.nc, "longitude")
lat <- ncvar_get(HighVegLAI.nc, "latitude")
time <- ncvar_get(HighVegLAI.nc, "time")
lai <- ncvar_get(HighVegLAI.nc, "lai_hv")

tic("Loading all LAI Months")
for(i in 1:80){
  HighVegLAI.raster[[i]] <- raster(lai[, , i], xmn=min(lat), xmx=max(lat), 
                                    ymn=min(lon), ymx=max(lon), 
                                   crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  HighVegLAI.raster[[i]] <- t(HighVegLAI.raster[[i]])
}
toc()
plot(HighVegLAI.raster[[1]])
#-------------------------------------------------------------------------------
#Create Rasters for Low Vegetation LAI
#-------------------------------------------------------------------------------
#Get variables
lon <- ncvar_get(LowVegLAI.nc, "longitude")
lat <- ncvar_get(LowVegLAI.nc, "latitude")
time <- ncvar_get(LowVegLAI.nc, "time")
lai <- ncvar_get(LowVegLAI.nc, "lai_lv")

tic("Loading all LAI Months")
for(i in 1:80){
  LowVegLAI.raster[[i]] <- raster(lai[, , i], xmn=min(lat), xmx=max(lat), 
                                   ymn=min(lon), ymx=max(lon), 
                                   crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  LowVegLAI.raster[[i]] <- t(LowVegLAI.raster[[i]])
}
toc()
plot(LowVegLAI.raster[[1]])
#-------------------------------------------------------------------------------
#Create Rasters for Temperature
#-------------------------------------------------------------------------------
#Get variables
lon <- ncvar_get(Temperature.nc, "longitude")
lat <- ncvar_get(Temperature.nc, "latitude")
time <- ncvar_get(Temperature.nc, "time")
temperature <- ncvar_get(Temperature.nc, "t2m")

tic("Loading all LAI Months")
for(i in 1:80){
  Temperature.raster[[i]] <- raster(temperature[, , i], xmn=min(lat), xmx=max(lat), 
                                  ymn=min(lon), ymx=max(lon), 
                                  crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  Temperature.raster[[i]] <- t(Temperature.raster[[i]])
}
toc()
plot(Temperature.raster[[1]])
#-------------------------------------------------------------------------------
#Create Rasters for monthly rainfall
#-------------------------------------------------------------------------------
#Get variables 
lon <- ncvar_get(TAMSATMonth.nc, "X")
lat <- ncvar_get(TAMSATMonth.nc, "Y")
time <- ncvar_get(TAMSATMonth.nc, "T")
rainfall <- ncvar_get(TAMSATMonth.nc, "rfe")

tic("Loading all TAMSAT Months")
for(i in 1:480){
  TAMSATMonth.raster[[i]] <- raster(rainfall[, , i], xmn=min(lat), xmx=max(lat), 
                                    ymn=min(lon), ymx=max(lon), 
                                    crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  TAMSATMonth.raster[[i]] <- t(TAMSATMonth.raster[[i]])
  TAMSATMonth.raster[[i]] <- flip(TAMSATMonth.raster[[i]], 2)
}
toc()
plot(TAMSATMonth.raster[[360]])