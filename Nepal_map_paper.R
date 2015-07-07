setwd('/home/rebeldroid12/Nepal_TeamViz/merged_data')

install.packages("maptools")
install.packages("sp")
install.packages("RColorBrewer")
install.packages("rgdal")
install.packages("classInt")

library(maptools)
library(sp)
library(RColorBrewer)
library(rgdal)
library(classInt)

#details
getinfo.shape("full_dist_merged_data.shp")


#QGIS: merged swb calculated vars & shp
#load merged data shapefiles

#read in files (district)
district_shp = readShapeLines('full_dist_merged_data.shp', proj4string=CRS("+proj=longlat"))
district_csv = read.csv('score_dist_final_20150616.csv', sep=",", header=TRUE)


#make vars/measures numeric & rename
district_shp$total_pop = as.numeric(as.character(district_shp$score_dist))
district_shp$obs_death = as.numeric(as.character(district_shp$score_di_1))
district_shp$obs_injured = as.numeric(as.character(district_shp$score_di_2))
district_shp$obs_mmi_max_dist = as.numeric(as.character(district_shp$score_di_3))
district_shp$obs_casualty = as.numeric(as.character(district_shp$score_di_4))
district_shp$pred_death = as.numeric(as.character(district_shp$score_di_5))
district_shp$pred_rate = as.numeric(as.character(district_shp$score_di_6))
district_shp$pred_density = as.numeric(as.character(district_shp$score_di_7))
district_shp$index_cnt = as.numeric(as.character(district_shp$score_di_8))
district_shp$index_rate = as.numeric(as.character(district_shp$score_di_9))
district_shp$index_density = as.numeric(as.character(district_shp$score_di10))
district_shp$wpredicted = as.numeric(as.character(district_shp$score_di11))
district_shp$index_roof = as.numeric(as.character(district_shp$score_di12))
district_shp$index_wall = as.numeric(as.character(district_shp$score_di13))

#change NAs back to zero
district_shp$obs_death[is.na(district_shp$obs_death)] <- 0
district_shp$obs_injured[is.na(district_shp$obs_injured)] <- 0
district_shp$obs_mmi_max_dist[is.na(district_shp$obs_mmi_max_dist)] <- 0
district_shp$obs_casualty[is.na(district_shp$obs_casualty)] <- 0
district_shp$pred_death[is.na(district_shp$pred_death)] <- 0
district_shp$pred_rate[is.na(district_shp$pred_rate)] <- 0
district_shp$pred_density[is.na(district_shp$pred_density)] <- 0
district_shp$index_cnt[is.na(district_shp$index_cnt)] <- 0
district_shp$index_rate[is.na(district_shp$index_rate)] <- 0
district_shp$index_density[is.na(district_shp$index_density)] <- 0
district_shp$wpredicted[is.na(district_shp$wpredicted)] <- 0
district_shp$index_roof[is.na(district_shp$index_roof)] <- 0
district_shp$index_wall[is.na(district_shp$index_wall)] <- 0



# equal-frequency class intervals
plotvar <- district_shp@data$obs_death
nclr <- 5
plotclr <- brewer.pal(nclr,"BuPu")
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)

#district_shp@bbox
#       min      max
#x 80.05845 88.20153
#y 26.34797 30.44739

plot(district_shp)
plot(district_shp, col=colcode, add=T)
title(main="Observed Deaths", 
      sub="Quantile (Equal-Frequency) Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")), 
       fill=attr(colcode, "palette"), cex=0.6, bty="n")


#colors <- brewer.pal(9, "YlOrRd")
#set breaks for the 9 colors 
#brks<-classIntervals(district_shp$obs_death, n=9, style="quantile")
#brks<- brks$brks

plot(district_shp, col=colors[findInterval(district_shp$obs_death, brks,all.inside=TRUE)], axes=F)



#print map
png(filename="./merged_data/districts/obs_death.png")


#plot prettiness!
plot(districts, col=gray(district_shp$obs_death/max(district_shp$obs_death)))
title(paste ("Nepal April 2015 Earthquake Observed deaths"))
#plot(districts, col=colors[findInterval(district_shp$obs_death, brks,all.inside=TRUE)], axes=F)
dev.off();


dev.copy(jpeg,filename="./merged_data/districts/obs_death.jpg");
dev.off();
#plot maps
#plot(districts)
#plot(vdcs)


