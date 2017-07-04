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
numSamples <- 1000
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
z2[z2!=0] <- 2
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$PRTIME)
xmax <-max(x4$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z4 <- h4$mids
z4[z4!=0] <- 4


install.packages("scatterplot3d")
require(scatterplot3d)
library(scatterplot3d)
x <- c(h1$mids,h2$mids,h4$mids)
y <- c(h1$counts,h2$counts,h4$counts)
z <- c(z1,z2,z4)
postscript("3d_plot.eps")
scatterplot3d(z,x,y, xlim=c(0,5),xlab="INC Length (sec)",ylab="INC Time (msec)",zlab="Frequency",main="3D Scatterplot")
dev.off()

x <- c(h1$mids,h2$mids,h4$mids)
y <- c(1,2,4)
z <- c(h1$counts,h2$counts,h4$counts)
mz=matrix(z, nrow=length(x),ncol=length(y), byrow=F)
mz[(length(h1$mids)+1):(length(x)),1] <- 0
mz[1:length(h1$mids),2] <- 0
mz[(length(h1$mids)+length(h2$mids)+1):(length(x)),2] <- 0
mz[1:(length(h1$mids)+length(h2$mids)),3] <- 0
postscript("3d_plot2.eps")
hist3D(x,y,mz,clim=c(0,4040),zlim=c(0,1000), ylim=c(0,5), xlab="INC Time (msec)",ylab="INC Length (sec)",zlab="Frequency",theta=30, phi=20, border = "black", axes=TRUE,label=TRUE, nticks=10,ticktype="detailed", space=0.2) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
dev.off()

plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=x,labels=seq(xmin,xmax,1000))
dev.off()



hist3D(x,y,mz, xlim=c(980,1010), zlim=c(0,1000), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5, 
        ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5,xlab="INC Time (msec)",ylab="INC Length",zlab="Frequency")


#y <- c(y1,y2,y4)
y <- c(1000,2000,4000)
zero_vec <- c(0,0,0)
z <- c(h1$counts,h2$counts,h4$counts)
mz=matrix(z, nrow=10,ncol=3, byrow=F)



hist3D(x,y,mz, xlim=c(980,4020), zlim=c(0,1000), ylim=c(1,4), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5, 
        ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5)



y <- as.matrix(y)
y <- as.vector(y)
z <- c(z1, z2, z4)
z <- as.matrix(z)
z <- t(z)
mz = matrix(rep(z,length(z)),nrow=length(z),byrow=T)
#mz=matrix(rep(z,lz), ncol=lz, byrow=T)
#scatter3D(x, y, z, phi = 0, bty = "g",  type = "h", #ticktype = "detailed", pch = 19, cex = 0.5)
#z <- as.matrix(z)
#lz=length(z)
#z=matrix(rep(z,lz), ncol=lz, byrow=F)
hist3D(x,y,mz, xlim=c(980,4020), ylim=c(0,1000), zlim=c(1,4), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5, 
        ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5)


hist3D(x,y,z, xlim=c(980,4020), ylim=c(0,1000), zlim=c(1,4), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5, 
        ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5)

