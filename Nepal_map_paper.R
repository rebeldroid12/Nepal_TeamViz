install.packages('maptools')
library(maptools)

classIntervals <- function(var, n, style="quantile", rtimes=3, ..., intervalClosure=c("left", "right"), dataPrecision=NULL) {
        if (is.factor(var)) stop("var is categorical")
        if (!is.numeric(var)) stop("var is not numeric") }

setwd('/home/rebeldroid12/Nepal_TeamViz')

districts = readShapeSpatial('npl_polbnda_adm3_dis_25k_50k_sdn_wgs84/npl_polbnda_adm3_dis_25k_50k_sdn_wgs84.shp')

vdcs = readShapeSpatial('npl_polbnda_adm4_vdc_25k_50k_sdn_wgs84/npl_polbnda_adm4_vdc_25k_50k_sdn_wgs84.shp') 

districts_var = read.csv('score_dist_final_20150616.csv', sep = ',', header=TRUE)
        
vdcs_var = read.csv('score_vdc_final_20150616.csv', sep = ',', header=TRUE)


#plot maps
plot(districts)
plot(vdcs)

#loop through districts vars
for (i in names(districts_var)) {print(i)}



#loop through vdcs vars
for (i in names(vdcs_var)) {print(i)}