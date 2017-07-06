nx <- c(x1_pt,x2_pt,x4_pt,x8_pt)
ny <- c(y1_pt,y2_pt,y4_pt,y8_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt)

mz=matrix(nz, nrow=length(nx),ncol=length(ny), byrow=F)
## 1 sec
mz[(length(x1_pt)+1):(length(nx)),1] <- NA
## 2 sec
mz[1:length(x1_pt),2] <- NA
mz[(length(x1_pt)+length(x2_pt)+1):(length(nx)),2] <- NA
## 4 sec
mz[1:(length(x1_pt)+length(x2_pt)),3] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+1):(length(nx)),3] <- NA
## 8 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)),4] <- NA

postscript("3d_plot.eps")
#hist3D(x,y,mz,xlim=c(0,17000),zlim=c(0,1000), ylim=c(0,13), xlab="INC Time (msec)",ylab="INC Length (sec)",zlab="Frequency",theta=30, phi=20, border = "black", axes=TRUE,label=TRUE, nticks=10,ticktype="detailed", space=0.2) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
hist3D(nx,ny,mz,log='xy',zlim=c(0,1), xlab="Relative INC Difference",ylab="Task Length in log scale",zlab="Relative Frequency",
theta=30, phi=20, border = "black",axes=TRUE,label=TRUE, ticktype="detailed", nticks=13,space=0.1) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
dev.off()



==
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
### 8 sec
x8 = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x8 <- subset(x8, x8$ITERNUM <= numSamples)
x8 <- subset(x8, x8$ITERNUM != 27)
xmin <-min(x8$PRTIME)
xmax <-max(x8$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h8 = hist(x8$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z8 <- h8$mids
z8[z8!=0] <- 8
### 16 sec
x16 = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x16 <- subset(x16, x16$ITERNUM <= numSamples)
xmin <-min(x16$PRTIME)
xmax <-max(x16$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16 = hist(x16$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z16 <- h16$mids
z16[z16!=0] <- 16
### 32 sec
x32 = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x32 <- subset(x32, x32$ITERNUM <= numSamples)
x32 <- subset(x32, x32$ITERNUM != 433)
xmin <-min(x32$PRTIME)
xmax <-max(x32$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h32 = hist(x32$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z32 <- h32$mids
z32[z32!=0] <- 32
### 64 sec
x64 = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x64 <- subset(x64, x64$ITERNUM <= numSamples)
xmin <-min(x64$PRTIME)
xmax <-max(x64$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h64 = hist(x64$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z64 <- h64$mids
z64[z64!=0] <- 64
### 128 sec
x128 = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x128 <- subset(x128, x128$ITERNUM <= numSamples)
x128 <- subset(x128, x128$ITERNUM != 26)
xmin <-min(x128$PRTIME)
xmax <-max(x128$PRTIME)
binsize=2
nbins <- ceiling((xmax-xmin) / binsize)
h128 = hist(x128$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z128 <- h128$mids
z128[z128!=0] <- 128
### 256 sec
x256 = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x256 <- subset(x256, x256$ITERNUM <= numSamples)
x256 <- subset(x256, x256$ITERNUM != 199)
xmin <-min(x256$PRTIME)
xmax <-max(x256$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h256 = hist(x256$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z256 <- h256$mids
z256[z256!=0] <- 256
### 512 sec
x512 = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x512 <- subset(x512, x512$ITERNUM <= numSamples)
x512 <- subset(x512, x512$ITERNUM != 114 & x512$ITERNUM != 186 & x512$ITERNUM != 285)
xmin <-min(x512$PRTIME)
xmax <-max(x512$PRTIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h512 = hist(x512$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z512 <- h512$mids
z512[z512!=0] <- 512
### 1024 sec
x1024 = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x1024 <- subset(x1024, x1024$ITERNUM <= numSamples)
x1024 <- subset(x1024, x1024$ITERNUM != 17 & x1024$ITERNUM != 101 & x1024$ITERNUM != 184 & x1024$ITERNUM != 268)
xmin <-min(x1024$PRTIME)
xmax <-max(x1024$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1024 = hist(x1024$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z1024 <- h1024$mids
#z1024[z1024!=0] <- 10
z1024[z1024!=0] <- 1024
### 2048 sec
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048 <- subset(x2048, x2048$ITERNUM <= numSamples)
xmin <-min(x2048$PRTIME)
xmax <-max(x2048$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z2048 <- h2048$mids
#z2048[z2048!=0] <- 11
z2048[z2048!=0] <- 2048
### 4096 sec
x4096 = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x4096 <- subset(x4096, x4096$ITERNUM <= numSamples)
x4096 <- subset(x4096, x4096$ITERNUM != 5 & x4096$ITERNUM != 26 & x4096$ITERNUM != 47 & x4096$ITERNUM != 68 & x4096$ITERNUM != 89 & x4096$ITERNUM != 110 & x4096$ITERNUM != 131 & x4096$ITERNUM != 152 & x4096$ITERNUM != 173 & x4096$ITERNUM != 195 & x4096$ITERNUM != 215 & x4096$ITERNUM != 236 & x4096$ITERNUM != 258 & x4096$ITERNUM != 278 & x4096$ITERNUM != 299) 
xmin <-min(x4096$PRTIME)
xmax <-max(x4096$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4096 = hist(x4096$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
z4096 <- h4096$mids
#z4096[z4096!=0] <- 12
z4096[z4096!=0] <- 4096

#####
#install.packages("scatterplot3d")
require(scatterplot3d)
library(scatterplot3d)
x <- c(z1,z2,z4,z8,z16,z32,z64,z128,z256,z512,z1024,z2048,z4096)
y <- c(h1$mids,h2$mids,h4$mids,h8$mids,h16$mids,h32$mids,h64$mids,h128$mids,h256$mids,h512$mids,h1024$mids,h2048$mids,h4096$mids)
z <- c(h1$counts,h2$counts,h4$counts,h8$counts,h16$counts,h32$counts,h64$counts,h128$counts,h256$counts,h512$counts,h1024$counts,h2048$counts,h4096$counts)
postscript("3d_plot.eps")
#marks <- c(0,1000000,2000000,4000000,8000000)
#scatterplot3d(x,y,z,xlim=c(-1,4100),ylim=c(0,4300000),y.ticklabs=c("0","1K sec","2K sec","3K sec","4K sec","8K sec"),log="xy",color="blue",pch=19,type="h",xlab="INC Length (sec) in log", ylab = "INC Time in log",zlab="Frequency",main="Frequency of INC Time over Increasing Task Length")
scatterplot3d(x,y,z,xlim=c(-1,4100),ylim=c(0,4300000),y.ticklabs=c("0","1K sec","2K sec","3K sec","4K sec","8K sec"),log="xy",color="blue",pch=19,type="h",xlab="INC Length (sec) in log", ylab = "INC Time in log",zlab="Frequency",main="Frequency of INC Time over Increasing Task Length")
#axis(2,at=marks,labels=marks)
#text(x = 14, y = 1e+06, "INC Time (msec)", srt = 45)
#ylab="INC Time (msec)",
#aty <- axTicks(2)
#labels <- sapply(aty,function(i)
#            as.expression(bquote(10^ .(i)))
#          )
#axis(2,at=aty,labels=labels)
#y.ticklabs=c("0","1K sec","2K sec","4K sec","8K sec"),
dev.off()


postscript("3d_plot2.eps")
hist3D(x,y,mz,xlim=c(0,17000),zlim=c(0,1000), ylim=c(0,13), xlab="INC Time (msec)",ylab="INC Length (sec)",zlab="Frequency",theta=30, phi=20, border = "black", axes=TRUE,label=TRUE, nticks=10,ticktype="detailed", space=0.2) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
dev.off()

====================================================================

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

