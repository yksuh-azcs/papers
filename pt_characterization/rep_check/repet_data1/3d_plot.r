### sodb9
#install.packages("devtools")
#library(devtools)
#install.packages("rgl")
#library(rgl)
require(rgl)

install.packages("misc3d")
install.packages("plot3D", repos="http://R-Forge.R-project.org")
require(plot3D)
library(plot3D)
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
binsize=1
xmin <-min(x1$PRTIME)
xmax <-max(x1$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z1 <- h1$mids
z1[z1!=0] <- 1
### 2 sec
x2 = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x2 <- subset(x2, x2$ITERNUM <= numSamples)
xmin <-min(x2$PRTIME)
xmax <-max(x2$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2 = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z2 <- h2$mids
z2[z2!=0] <- 1
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$PRTIME)
xmax <-max(x4$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z4 <- h4$mids
z4[z4!=0] <- 1

x <- c(h1$mids,h2$mids,h4$mids)
y <- c(h1$counts,h2$counts,h4$counts)
z <- c(z1, z2, z4)


hist3D(x,y,z, zlim=c(0,50), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5, 
        ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5)

