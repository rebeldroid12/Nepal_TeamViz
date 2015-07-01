install.packages('maptools')
library(maptools)

install.packages('rgdal') #install gdal
library(rgdal)

install.packages('RColorBrewer')
library(RColorBrewer)

#install.packages('')

classIntervals <- function(var, n, style="quantile", rtimes=3, ..., intervalClosure=c("left", "right"), dataPrecision=NULL) {
        if (is.factor(var)) stop("var is categorical")
        if (!is.numeric(var)) stop("var is not numeric") }

setwd('/home/rebeldroid12/Nepal_TeamViz')

#QGIS: merged swb calculated vars & shp
#load merged data shapefiles
districts = readShapeSpatial('merged_data/districts/full_dist_merged_data.shp')

#calculated vars
#districts_var = read.csv('score_dist_final_20150616.csv', sep = ',', header=TRUE)
#vdcs_var = read.csv('score_vdc_final_20150616.csv', sep = ',', header=TRUE)

#make vars/measures numeric & rename
districts$total_pop = as.numeric(districts$score_dist)
districts$obs_death = as.numeric(districts$score_di_1)
districts$obs_injured = as.numeric(districts$score_di_2)
districts$obs_mmi_max_dist = as.numeric(districts$score_di_3)
districts$obs_casualty = as.numeric(districts$score_di_4)
districts$pred_death = as.numeric(districts$score_di_5)
districts$pred_rate = as.numeric(districts$score_di_6)
districts$pred_density = as.numeric(districts$score_di_7)
districts$index_cnt = as.numeric(districts$score_di_8)
districts$index_rate = as.numeric(districts$score_di_9)
districts$index_density = as.numeric(districts$score_di10)
districts$wpredicted = as.numeric(districts$score_di11)
districts$index_roof = as.numeric(districts$score_di12)
districts$index_wall = as.numeric(districts$score_di13)

#change NAs back to zero
districts$obs_death[is.na(districts$obs_death)] <- 0
districts$obs_injured[is.na(districts$obs_injured)] <- 0
districts$obs_mmi_max_dist[is.na(districts$obs_mmi_max_dist)] <- 0
districts$obs_casualty[is.na(districts$obs_casualty)] <- 0
districts$pred_death[is.na(districts$pred_death)] <- 0
districts$pred_rate[is.na(districts$pred_rate)] <- 0
districts$pred_density[is.na(districts$pred_density)] <- 0
districts$index_cnt[is.na(districts$index_cnt)] <- 0
districts$index_rate[is.na(districts$index_rate)] <- 0
districts$index_density[is.na(districts$index_density)] <- 0
districts$wpredicted[is.na(districts$wpredicted)] <- 0
districts$index_roof[is.na(districts$index_roof)] <- 0
districts$index_wall[is.na(districts$index_wall)] <- 0


#create color breaks (9)
colors <- brewer.pal(9, "YlOrRd")
brks<-classIntervals(districts$obs_deaths, n=9, style="quantile")
brks<- brks$brks


#print map
png(filename="./merged_data/districts/obs_death.png")


#plot prettiness!
plot(districts, col=gray(districts$obs_death/max(districts$obs_death)))
title(paste ("Nepal April 2015 Earthquake Observed deaths"))
#plot(districts, col=colors[findInterval(districts$obs_death, brks,all.inside=TRUE)], axes=F)
dev.off();


dev.copy(jpeg,filename="./merged_data/districts/obs_death.jpg");
dev.off();
#plot maps
#plot(districts)
#plot(vdcs)


