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